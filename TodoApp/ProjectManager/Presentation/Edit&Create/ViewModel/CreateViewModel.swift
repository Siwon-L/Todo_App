//
//  CreateViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/26.
//

import Foundation

import RxSwift

protocol CreateViewModelInput {
    func createButtonDidTap()
    func inputitle(title: String?)
    func inputDeadline(deadline: Date)
    func inputBody(body: String?)
}

protocol CreateViewModelOutput {}

protocol CreateViewModel: CreateViewModelInput, CreateViewModelOutput {}

final class DefaultCreateViewModel {
    private let useCase: TodoListUseCase
    private var item: TodoModel
    
    init(useCase: TodoListUseCase, item: TodoModel = TodoModel()) {
        self.useCase = useCase
        self.item = item
    }
}

extension DefaultCreateViewModel: CreateViewModel {
    func createButtonDidTap() {
        if item.title?.isEmpty == true && item.body?.isEmpty == true { return }
        useCase.createItem(to: item)
    }
    
    func inputitle(title: String?) {
        item.title = title
    }
    
    func inputDeadline(deadline: Date) {
        item.deadlineAt = deadline
    }
    
    func inputBody(body: String?) {
        item.body = body
    }
}
