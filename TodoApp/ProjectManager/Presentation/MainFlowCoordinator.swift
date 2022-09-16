//
//  MainFlowCoordinator.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/09.
//

import UIKit

protocol MainFlowCoordinatorDependencies {
    func makePageViewController(coordinator: PageViewDependencies, viewControllers: [ContentListViewController]) -> PageViewController
    func makeContentViewControllers(coordinator: ContentListViewDependencies) -> [ContentListViewController]
    func makeTodoEditViewController(item: TodoModel?,
                                    coordinator: TodoEditViewControllerDependencies) -> TodoEditViewController
    func makeTodoMoveViewController(item: TodoModel,
                                    coordinator: TodoMoveViewControllerDependencies) -> TodoMoveViewController
    func makeHistoryViewController(coordinator: HistoryViewControllerDependencies) -> HistoryViewController
}

final class MainFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: MainFlowCoordinatorDependencies
    private weak var pageViewController: PageViewController?
    private weak var todoEditViewController: TodoEditViewController?
    private weak var todoMoveViewController: TodoMoveViewController?
    private weak var historyViewController: HistoryViewController?
    
    init(navigationController: UINavigationController, dependencies: MainFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
}

extension MainFlowCoordinator {
    func start() {
        let viewController = dependencies.makePageViewController(
            coordinator: self,
            viewControllers: dependencies.makeContentViewControllers(
                coordinator: self
            )
        )
        navigationController?.pushViewController(viewController, animated: true)
        pageViewController = viewController
    }
}

extension MainFlowCoordinator: PageViewDependencies {
    func presentPlusViewController() {
        presentEditViewController(item: nil)
    }
    
    func pushHistoryViewController(button: UIBarButtonItem) {
        let viewController = dependencies.makeHistoryViewController(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
        historyViewController = viewController
    }
}

extension MainFlowCoordinator: ContentListViewDependencies {
    func presentEditViewController(item: TodoModel?) {
        let viewController = dependencies.makeTodoEditViewController(item: item, coordinator: self)
        viewController.modalPresentationStyle = .formSheet
        pageViewController?.present(viewController, animated: true)
        todoEditViewController = viewController
    }
    
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel) {
        let viewController = dependencies.makeTodoMoveViewController(item: item, coordinator:  self)
        viewController.modalPresentationStyle = .popover
        viewController.preferredContentSize = CGSize(width: 300, height: 130)
        viewController.popoverPresentationController?.sourceView = cell
        viewController.popoverPresentationController?.sourceRect = cell?.bounds ?? .zero
        viewController.popoverPresentationController?.permittedArrowDirections = .up
        pageViewController?.present(viewController, animated: true)
        
        todoMoveViewController = viewController
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        pageViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension MainFlowCoordinator: TodoEditViewControllerDependencies {
    func dismissEditViewController() {
        todoEditViewController?.dismiss(animated: true)
    }
}

extension MainFlowCoordinator: TodoMoveViewControllerDependencies {
    func dismissMoveViewController() {
        todoMoveViewController?.dismiss(animated: true)
    }
}

extension MainFlowCoordinator: HistoryViewControllerDependencies {
    func popHistoryViewController() {
        navigationController?.popViewController(animated: true)
    }
}
