//
//  CustomUITableView.swift
//  CustomUIKit
//
//  Created by 이시원 on 2022/09/29.
//

import UIKit

public final class CUITableView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerView, tableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public let headerView: CUIHeaderView
   
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    public init(title: String? = nil) {
        headerView = CUIHeaderView(title: title)
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func register(_ cellClass: AnyClass, forCellReuseIdentifier: String) {
        tableView.register(cellClass, forCellReuseIdentifier: forCellReuseIdentifier)
    }
    
    
    private func configureLayout() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
