//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ContentListViewDependencies: AnyObject {
    func pushEditViewController(item: TodoModel)
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel)
    func showErrorAlert(message: String)
}

final class ContentListViewController: UIViewController {
    private let mainView = ContentListView()
    private let viewModel: ContentListViewModel
    private weak var coordinator: ContentListViewDependencies?
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    init(viewModel: ContentListViewModel, coordinator: ContentListViewDependencies?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension ContentListViewController {
    private func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - ViewModel Bind
extension ContentListViewController {
    private func bind() {
        viewModel.contentList
            .bind(
                to: mainView.list.tableView.rx.items(
                    cellIdentifier: TodoListCell.identifier,
                    cellType: TodoListCell.self
                )
            ) { row, item, cell in
                cell.setContent(item: item)
            }.disposed(by: bag)
        
        viewModel.listTitle
            .drive(mainView.list.headerView.rx.titleText)
            .disposed(by: bag)
        
        viewModel.contentCount
            .drive(mainView.list.headerView.rx.countText)
            .disposed(by: bag)
        
        //MARK: - Event
        mainView.list.tableView.rx.listLongPress(ContentCellItem.self)
            .bind { [weak self] (cell, item) in
                guard let item = self?.viewModel.cellSelected(id: item.id) else { return }
                self?.coordinator?.popoverMoveViewController(cell: cell, item: item)
            }.disposed(by: bag)
        
        mainView.list.tableView.rx.listItemSelected(ContentCellItem.self)
            .bind { [weak self] (indexPath, item) in
                self?.mainView.list.tableView.deselectRow(at: indexPath, animated: true)
                guard let item = self?.viewModel.cellSelected(id: item.id) else { return }
                self?.coordinator?.pushEditViewController(item: item)
            }.disposed(by: bag)
    }
}
