//
//  TodoListUseCase.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation
import RxSwift

protocol UseCase {
    func readRepository() -> BehaviorSubject<[TodoModel]>
    func saveRepository(to data: TodoModel)
    func checkDeadline(time: Date) -> Bool
    func changeToTitle(at state: State) -> (String, String)
}

final class TodoListUseCase: UseCase {
    private let repository: TodoListRepository
    
    init(repository: TodoListRepository) {
        self.repository = repository
    }
}

extension TodoListUseCase {

    func readRepository() -> BehaviorSubject<[TodoModel]> {
        return repository.read()
    }
    
    func saveRepository(to data: TodoModel) {
        repository.save(to: data)
    }
    
    func checkDeadline(time: Date) -> Bool {
        return time + 24 * 60 * 60 < Date()
    }
    
    func changeToTitle(at state: State) -> (String, String) {
        switch state {
        case .todo:
            return ("Move to DOING", "Move to DONE")
        case .doing:
            return ("Move to TODO", "Move to DONE")
        case .done:
            return ("Move to TODO", "Move to DOING")
        }
    }
}
