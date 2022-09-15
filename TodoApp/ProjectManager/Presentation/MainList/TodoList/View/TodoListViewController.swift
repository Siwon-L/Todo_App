//
//  ProjectManager - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class TodoListViewController: UIViewController {
    private let mainView = TodoListView()
    private let viewModel: TodoListViewModel
    private weak var coordinator: MainListViewDependencies?
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    init(viewModel: TodoListViewModel, coordinator: MainListViewDependencies?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension TodoListViewController {
    private func configureView() {
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - ViewModel Bind
extension TodoListViewController {
    private func bind() {
        
        //MARK: - TodoList
        viewModel.todoList
            .bind(
                to: mainView.todo.tableView.rx.items(
                    cellIdentifier: TodoListCell.identifier,
                    cellType: TodoListCell.self
                )
            ) { row, item, cell in
                cell.setContent(item: item)
            }.disposed(by: bag)
        
        viewModel.todoListCount
            .drive(mainView.todo.headerView.rx.countText)
            .disposed(by: bag)
        
        //MARK: - Event
        mainView.todo.tableView.rx.listLongPress(TodoCellContent.self)
            .bind { [weak self] (cell, item) in
                guard let item = self?.viewModel.cellSelected(id: item.id) else { return }
                self?.coordinator?.popoverMoveViewController(cell: cell, item: item)
            }.disposed(by: bag)
        
        mainView.todo.tableView.rx.listItemSelected(TodoCellContent.self)
            .bind { [weak self] (indexPath, item) in
                self?.mainView.todo.tableView.deselectRow(at: indexPath, animated: true)
                let item = self?.viewModel.cellSelected(id: item.id)
                self?.coordinator?.presentEditViewController(item: item)
            }.disposed(by: bag)
        
        mainView.todo.tableView.rx.modelDeleted(TodoCellContent.self)
            .bind { [weak self] item in
                self?.viewModel.cellDeleteButtonDidTap(item: item)
            }.disposed(by: bag)
        
        //MARK: - Error Handling
        viewModel.errorMessage
            .bind { [weak self] message in
                self?.coordinator?.showErrorAlert(message: message)
            }.disposed(by: bag)
    }
}
