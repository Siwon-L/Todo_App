//
//  DoneListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/13.
//

import UIKit
import SnapKit

final class DoneListView: UIView {
    let done = TodoListTableView(title: "DONE")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(done)
        done.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func tableViewdeselectRow(indexPath: IndexPath) {
        done.tableView.deselectRow(at: indexPath, animated: true)
    }
}
