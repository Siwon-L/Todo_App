//
//  DoingListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/14.
//

import Foundation
import RxSwift
import RxCocoa

protocol DoingListViewModelInput {
    func cellSelected(id: UUID) -> TodoModel?
    func cellDeleteButtonDidTap(item: TodoCellContent)
}

protocol DoingListViewModelOutput {
    var doingList: Observable<[TodoCellContent]> { get }
    var doingListCount: Driver<String> { get }
    var errorMessage: Observable<String> { get }
}

protocol DoingListViewModel: DoingListViewModelInput, DoingListViewModelOutput {}

final class DefaultDoingListViewModel {
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

extension DefaultDoingListViewModel: DoingListViewModel {
    //MARK: - Output
    var doingList: Observable<[TodoCellContent]> {
        useCase
            .readItems()
            .map {
                $0.filter { $0.state == .doing }
            }
            .distinctUntilChanged()
            .compactMap { [weak self] in
                self?.toTodoCellContents(todoModels: $0)
            }
    }

    var doingListCount: Driver<String> {
        doingList
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
