//
//  CreateView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/26.
//

import UIKit

import SnapKit

final class CreateView: CommonView {
    let navigationBar = UINavigationBar()
    
    override func configureLayout() {
        self.addSubview(navigationBar)
        self.addSubview(contentStackView)
        
        navigationBar.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(contentStackView.snp.top).inset(-20)
        }
        
        contentStackView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(self).multipliedBy(0.08)
        }
    }
}
