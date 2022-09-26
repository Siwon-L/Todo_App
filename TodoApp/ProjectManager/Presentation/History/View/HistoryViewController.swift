//
//  TodoHistoryViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/25.
//

import UIKit
import SnapKit
import RxSwift

final class HistoryViewController: UIViewController {
    
    private let viewModel: HistoryViewModel
    private let bag = DisposeBag()
    
    private let historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension HistoryViewController {
    private func configureView() {
        title = "History"
        view.backgroundColor = .systemBackground
        self.view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - ViewModel Bind
extension HistoryViewController {
    private func bind() {
        viewModel.historyList
            .bind(
                to: historyTableView.rx.items(
                    cellIdentifier: HistoryCell.identifier,
                    cellType: HistoryCell.self
                )
            ) { row, item, cell in
                cell.setContent(item: item)
            }.disposed(by: bag)
    }
}
