//
//  PageViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/13.
//

import UIKit

import SnapKit
import RxSwift

protocol PageViewDependencies: AnyObject {
    func presentPlusViewController()
    func pushHistoryViewController(button: UIBarButtonItem)
    func showErrorAlert(message: String)
}

final class PageViewController: UIViewController {
    private enum Constant {
        static let navigationBarTitle = "Project Manager"
    }
    private let viewModel: PageViewModel
    private weak var coordinator: PageViewDependencies?
    private let viewControllers: [UIViewController]
    private let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private let historyButton = UIBarButtonItem()
    private let bag = DisposeBag()
    
    private lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return vc
    }()
    
    init(
        viewControllers: [UIViewController],
        viewModel: PageViewModel,
        coordinator: PageViewDependencies
    ) {
        self.viewControllers = viewControllers
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.dataSource = self
        pageViewController.delegate = self
        configureUI()
        configureNavigationBar()
        bind()
    }
    
    private func configureNavigationBar() {
        title = Constant.navigationBarTitle
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = historyButton
        historyButton.title = "History"
    }
}

extension PageViewController {
    private func bind() {
        //MARK: - Error Handling
        viewModel.errorMessage
            .bind { [weak self] message in
                self?.coordinator?.showErrorAlert(message: message)
            }.disposed(by: bag)
        
        plusButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.presentPlusViewController()
            }.disposed(by: bag)
        
        historyButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.coordinator?.pushHistoryViewController(button: self.historyButton)
            }.disposed(by: bag)
    }
}

extension PageViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.pageViewController
            .setViewControllers(
                [viewControllers.first ?? UIViewController()],
                direction: .reverse,
                animated: true
            )
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return viewControllers.last
        }
        return viewControllers[previousIndex]
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewControllers.count {
            return viewControllers.first
        }
        return viewControllers[nextIndex]
    }
}
