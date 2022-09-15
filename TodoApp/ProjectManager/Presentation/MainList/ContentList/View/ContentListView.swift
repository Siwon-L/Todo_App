//
//  TodoListView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/05.
//

import UIKit
import SnapKit

final class ContentListView: UIView {
    let list = TodoListTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        self.backgroundColor = .systemBackground
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        self.addSubview(list)
        list.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
