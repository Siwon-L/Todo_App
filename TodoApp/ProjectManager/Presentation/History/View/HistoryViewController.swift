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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
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
        titleLabel.text = "HISTORY"
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(historyTableView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(historyTableView.snp.top).inset(-8)
        }
        
        historyTableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
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
