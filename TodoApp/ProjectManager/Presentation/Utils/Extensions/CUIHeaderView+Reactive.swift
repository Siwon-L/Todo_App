//
//  TodoListHeaderView.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/10.
//

import RxSwift
import CustomUIKit

extension Reactive where Base == CUIHeaderView {
    var countText: Binder<String?> {
        return base.countLabel.rx.text
    }
    var titleText: Binder<String?> {
        return base.titleLabel.rx.text
    }
}
