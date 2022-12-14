//
//  MoveViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/14.
//

import Foundation
import RxSwift
import RxCocoa

protocol MoveViewModelInput {
    func firstButtonDidTap()
    func secondButtonDidTap()
    func deleteButonDidTap()
}

protocol MoveViewModelOutput {
    var buttonTitle: Observable<[String]> { get }
}

protocol MoveViewModel: MoveViewModelInput, MoveViewModelOutput {}

final class DefaultMoveViewModel {
    private let useCase: TodoListUseCase
    private let item: TodoModel
    
    init(useCase: TodoListUseCase, item: TodoModel) {
        self.useCase = useCase
        self.item = item
    }
    
    private func setButtonTitle(at state: State) -> [String] {
        switch state {
        case .todo:
            return ["Move to DOING", "Move to DONE"]
        case .doing:
            return ["Move to TODO", "Move to DONE"]
        case .done:
            return ["Move to TODO", "Move to DOING"]
        }
    }
}

extension DefaultMoveViewModel: MoveViewModel {
    
    //MARK: - Output
    var buttonTitle: Observable<[String]> {
        var buttonTitle = setButtonTitle(at: item.state)
        buttonTitle.append("Delete")
        
        return Observable.just(buttonTitle)
    }
    
    //MARK: - Input
    func firstButtonDidTap() {
        useCase.firstMoveState(item: item)
    }
    
    func secondButtonDidTap() {
        useCase.secondMoveState(item: item)
    }
    
    func deleteButonDidTap() {
        useCase.deleteItem(id: item.id)
    }
}
