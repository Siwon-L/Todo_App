//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa

protocol TodoListViewModelInput {
    func cellSelected(id: UUID) -> TodoModel?
    func cellDeleteButtonDidTap(item: TodoCellContent)
}

protocol TodoListViewModelOutput {
    var todoList: Observable<[TodoCellContent]> { get }
    var todoListCount: Driver<String> { get }
    var errorMessage: Observable<String> { get }
}

protocol TodoListViewModel: TodoListViewModelInput, TodoListViewModelOutput {}

final class DefaultTodoListViewModel {
    private let useCase: TodoListUseCase
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    private func toTodoCellContents(todoModels: [TodoModel]) -> [TodoCellContent] {
        todoModels.map { item in
            TodoCellContent(entity: item,
                            dateFormatter: dateFormatter)
        }
    }
}

extension DefaultTodoListViewModel: TodoListViewModel {
    //MARK: - Output
    var todoList: Observable<[TodoCellContent]> {
        useCase
            .readItems()
            .map {
                $0.filter { $0.state == .todo }
            }
            .distinctUntilChanged()
            .compactMap { [weak self] in
                self?.toTodoCellContents(todoModels: $0)
            }
    }

    var todoListCount: Driver<String> {
        todoList
            .map { "\($0.count)" }
            .asDriver(onErrorJustReturn: "0")
    }
    
    var errorMessage: Observable<String> {
        useCase.errorObserver
            .map { error in
                error.localizedDescription
            }
    }
    
    //MARK: - Input
    
    func cellSelected(id: UUID) -> TodoModel? {
        return try? useCase.readItems().value()
            .first { $0.id == id }
    }

    func cellDeleteButtonDidTap(item: TodoCellContent) {
        useCase.deleteItem(id: item.id)
    }
}
