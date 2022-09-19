//
//  TodoListViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa

protocol ContentListViewModelInput {
    func cellSelected(id: UUID) -> TodoModel?
}

protocol ContentListViewModelOutput {
    var contentList: Observable<[ContentCellItem]> { get }
    var listTitle: Driver<String> { get }
    var contentCount: Driver<String> { get }
}

protocol ContentListViewModel: ContentListViewModelInput, ContentListViewModelOutput {}

final class DefaultContentListViewModel {
    private let useCase: TodoListUseCase
    private let state: State
    init(useCase: TodoListUseCase, targetState: State) {
        self.useCase = useCase
        self.state = targetState
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. d"
        return dateFormatter
    }()
    
    private func toTodoCellContents(todoModels: [TodoModel]) -> [ContentCellItem] {
        todoModels.map { item in
            ContentCellItem(entity: item,
                            dateFormatter: dateFormatter)
        }
    }
}

extension DefaultContentListViewModel: ContentListViewModel {
    //MARK: - Output
    var contentList: Observable<[ContentCellItem]> {
        useCase
            .readItems()
            .map { [weak self] in
                $0.filter { $0.state == self?.state }
            }
            .distinctUntilChanged()
            .compactMap { [weak self] in
                self?.toTodoCellContents(todoModels: $0)
            }
    }
    
    var listTitle: Driver<String> {
        switch state {
        case .todo:
            return .just("TODO").asDriver()
        case .doing:
            return .just("DOING").asDriver()
        case .done:
            return .just("DONE").asDriver()
        }
    }

    var contentCount: Driver<String> {
        contentList
            .map { "\($0.count)" }
            .asDriver(onErrorJustReturn: "0")
    }
    
    //MARK: - Input
    
    func cellSelected(id: UUID) -> TodoModel? {
        return try? useCase.readItems().value()
            .first { $0.id == id }
    }
}
