//
//  DoneListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/14.
//

import Foundation
import RxSwift
import RxCocoa

protocol DoneListViewModelInput {
    func cellSelected(id: UUID) -> TodoModel?
    func cellDeleteButtonDidTap(item: TodoCellContent)
}

protocol DoneListViewModelOutput {
    var doneList: Observable<[TodoCellContent]> { get }
    var doneListCount: Driver<String> { get }
    var errorMessage: Observable<String> { get }
}

protocol DoneListViewModel: DoneListViewModelInput, DoneListViewModelOutput {}

final class DefaultDoneListViewModel {
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

extension DefaultDoneListViewModel: DoneListViewModel {
    //MARK: - Output
    var doneList: Observable<[TodoCellContent]> {
        useCase
            .readItems()
            .map {
                $0.filter { $0.state == .done }
            }
            .distinctUntilChanged()
            .compactMap { [weak self] in
                self?.toTodoCellContents(todoModels: $0)
            }
    }

    var doneListCount: Driver<String> {
        doneList
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
