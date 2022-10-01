//
//  MockUseCase.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/26.
//

import Foundation
import RxSwift
import RxCocoa
@testable import ProjectManager

enum UseCaseAction {
    case readItems
    case readHistorys
    case create
    case delete
    case update
    case firstMove
    case secondMove
}

class MockUseCase: TodoListUseCase {
    var errorObserver: Observable<TodoError> = Observable.just(.saveError)
    
    let todoList: BehaviorSubject<[TodoModel]>
    let historyList: BehaviorSubject<[History]>
    var actions: [UseCaseAction] = []
    var targetId: UUID?
    
    init(listData: [TodoModel] = [], historyData: [History] = []) {
        self.todoList = .init(value: listData)
        self.historyList = .init(value: historyData)
    }
    
    func readItems() -> BehaviorSubject<[TodoModel]> {
        actions.append(.readItems)
        return todoList
    }
    
    func readHistoryItems() -> BehaviorSubject<[History]> {
        actions.append(.readHistorys)
        return historyList
    }
    
    func createItem(to data: TodoModel) {
        actions.append(.create)
        targetId = data.id
    }
    
    func updateItem(to item: TodoModel) {
        actions.append(.update)
        targetId = item.id
    }
    
    func deleteItem(id: UUID) {
        actions.append(.delete)
        targetId = id
    }
    
    func firstMoveState(item: TodoModel) {
        actions.append(.firstMove)
        targetId = item.id
    }
    
    func secondMoveState(item: TodoModel) {
        actions.append(.secondMove)
        targetId = item.id
    }
}

