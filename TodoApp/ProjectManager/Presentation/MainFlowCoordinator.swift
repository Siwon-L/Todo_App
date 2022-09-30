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
    func makeEditViewController(item: TodoModel?) -> EditViewController
    func makeCreateViewController(coordinator: CreateViewControllerDependencies) -> CreateViewController
    func makeMoveViewController(item: TodoModel,
                                    coordinator: MoveViewControllerDependencies) -> MoveViewController
    func makeHistoryViewController() -> HistoryViewController
}

final class MainFlowCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: MainFlowCoordinatorDependencies
    private weak var pageViewController: PageViewController?
    private weak var editViewController: EditViewController?
    private weak var createViewController: CreateViewController?
    private weak var moveViewController: MoveViewController?
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
    func presentCreateViewController() {
        let viewController = dependencies.makeCreateViewController(coordinator: self)
        viewController.modalPresentationStyle = .formSheet
        pageViewController?.present(viewController, animated: true)
        createViewController = viewController
    }
    
    func pushHistoryViewController(button: UIBarButtonItem) {
        let viewController = dependencies.makeHistoryViewController()
        navigationController?.pushViewController(viewController, animated: true)
        historyViewController = viewController
    }
}

extension MainFlowCoordinator: ContentListViewDependencies {
    func pushEditViewController(item: TodoModel?) {
        let viewController = dependencies.makeEditViewController(item: item)
        navigationController?.pushViewController(viewController, animated: true)
        editViewController = viewController
    }
    
    func popoverMoveViewController(cell: UITableViewCell?, item: TodoModel) {
        let viewController = dependencies.makeMoveViewController(item: item, coordinator:  self)
        guard let sourceView = cell else { return }
        let sourceRect = CGRect(x: sourceView.bounds.midX / 2, y: sourceView.bounds.midY, width: 0, height: 0)
        
        viewController.modalPresentationStyle = .popover
        
        viewController.preferredContentSize = CGSize(width: 200, height: 120)
        viewController.popoverPresentationController?.sourceView = sourceView
        viewController.popoverPresentationController?.sourceRect = sourceRect
        if (pageViewController?.view.bounds.maxY ?? .zero) / 2 > sourceView.frame.maxY {
            viewController.popoverPresentationController?.permittedArrowDirections = .up
            viewController.arrowDirections = .up
        } else {
            viewController.popoverPresentationController?.permittedArrowDirections = .down
            viewController.arrowDirections = .down
        }
        viewController.popoverPresentationController?.delegate = pageViewController
        pageViewController?.present(viewController, animated: true)
        
        moveViewController = viewController
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "에러", message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "확인", style: .default))
        pageViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension MainFlowCoordinator: CreateViewControllerDependencies {
    func dismissCreateViewController() {
        createViewController?.dismiss(animated: true)
    }
}

extension MainFlowCoordinator: MoveViewControllerDependencies {
    func dismissMoveViewController() {
        moveViewController?.dismiss(animated: true)
    }
}
