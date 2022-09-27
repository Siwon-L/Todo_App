//
//  TodoEditViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import Foundation
import RxSwift
import RxRelay

protocol EditViewModelInput {
    func inputitle(title: String?)
    func inputDeadline(deadline: Date)
    func inputBody(body: String?)
    func editButtonDidTap()
    func popView()
}

protocol EditViewModelOutput {
    var setUpView: Observable<TodoModel?> { get }
    var setEditMode: BehaviorRelay<Bool> { get }
}

protocol EditViewModel: EditViewModelInput, EditViewModelOutput {}

final class DefaultEditViewModel {
    private let useCase: TodoListUseCase
    private var item: TodoModel?
    private var isEditMode = false
    var setEditMode = BehaviorRelay<Bool>(value: false)
    
    init(useCase: TodoListUseCase, item: TodoModel?) {
        self.useCase = useCase
        self.item = item
    }
}

extension DefaultEditViewModel: EditViewModel {
   
    //MARK: - Output
    var setUpView: Observable<TodoModel?> {
        return Observable.just(item)
    }
    
    //MARK: - Input
    func editButtonDidTap() {
        isEditMode = !isEditMode
        setEditMode.accept(isEditMode)
    }
    
    func popView() {
        useCase.updateItem(to: item!)
    }
    
    func inputitle(title: String?) {
        item?.title = title
    }
    
    func inputDeadline(deadline: Date) {
        item?.deadlineAt = deadline
    }
    
    func inputBody(body: String?) {
        item?.body = body
    }
}
