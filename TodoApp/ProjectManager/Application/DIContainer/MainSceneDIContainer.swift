//
//  TodoSceneDIContainer.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import Foundation

final class MainSceneDIContainer {
    private let todoListStorage = RealmTodoListStorage()
    private let historyStorage = RealmHistoryStorage()
    private let backUpStorage = FirebaseTodoListStorage()
    private let userStateStorage = UserDefaults()

    private func makePageViewModel() -> DefaultPageViewModel {
        return DefaultPageViewModel(useCase: makeTodoListUseCase())
    }
    
    private func makeContentListViewModel(targetState: State) -> DefaultContentListViewModel {
        return DefaultContentListViewModel(useCase: makeTodoListUseCase(), targetState: targetState)
    }
    
    private func makeTodoEditViewModel(item: TodoModel?) -> DefaultTodoEditViewModel {
        return DefaultTodoEditViewModel(useCase: makeTodoListUseCase(),
                                        item: item)
    }
    
    private func makeTodoMoveViewModel(item: TodoModel) -> TodoMoveViewModel {
        return DefaultTodoMoveViewModel(useCase: makeTodoListUseCase(), item: item)
    }
    
    private func makeHistoryViewModel() -> HistoryViewModel {
        return DefaultTodoHistoryViewModel(useCase: makeTodoListUseCase())
    }
    
    private func makeTodoListUseCase() -> DefaultTodoListUseCase {
        return DefaultTodoListUseCase(listRepository: makeTodoListRepository(),
                                      historyRepository: makeHistoryRepository())
    }
    
    private func makeTodoListRepository() -> DefaultTodoListRepository {
        return DefaultTodoListRepository(storage: todoListStorage, backUpStorage: backUpStorage, userStateStorage: userStateStorage)
    }
    
    private func makeHistoryRepository() -> DefaultHistoryRepository {
        return DefaultHistoryRepository(storage: historyStorage)
    }
}

extension MainSceneDIContainer: MainFlowCoordinatorDependencies {
    func makePageViewController(coordinator: PageViewDependencies, viewControllers: [ContentListViewController]) -> PageViewController {
        return PageViewController(viewControllers: viewControllers,
                                  viewModel: makePageViewModel(),
                                  coordinator: coordinator)
    }
    
    func makeContentViewControllers(coordinator: ContentListViewDependencies) -> [ContentListViewController] {
        return [
            ContentListViewController(viewModel: makeContentListViewModel(targetState: .todo), coordinator: coordinator),
            ContentListViewController(viewModel: makeContentListViewModel(targetState: .doing), coordinator: coordinator),
            ContentListViewController(viewModel: makeContentListViewModel(targetState: .done), coordinator: coordinator)
        ]
    }
    
    func makeTodoMoveViewController(item: TodoModel,
                                    coordinator: TodoMoveViewControllerDependencies) -> TodoMoveViewController {
        return TodoMoveViewController(viewModel: makeTodoMoveViewModel(item: item),
                                      coordinator: coordinator)
    }
    
    func makeTodoEditViewController(item: TodoModel?,
                                    coordinator: TodoEditViewControllerDependencies) -> TodoEditViewController {
        return TodoEditViewController(viewModel: makeTodoEditViewModel(item: item),
                                      coordinator: coordinator)

    }
    
    func makeHistoryViewController() -> HistoryViewController {
        return HistoryViewController(viewModel: makeHistoryViewModel())
    }
}
