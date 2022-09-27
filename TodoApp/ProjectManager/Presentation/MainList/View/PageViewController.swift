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
    func presentCreateViewController()
    func pushHistoryViewController(button: UIBarButtonItem)
    func showErrorAlert(message: String)
}

final class PageViewController: UIViewController {
    private let viewModel: PageViewModel
    private weak var coordinator: PageViewDependencies?
    private let viewControllers: [UIViewController]
    private let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    private let historyButton = UIBarButtonItem()
    private let bag = DisposeBag()
    private let segmentedControl: UnderLineSegmentedControl = {
        let control = UnderLineSegmentedControl(
            items: [
                "TODO",
                "DOING",
                "DONE"
            ]
        )
        control.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 13),
             .foregroundColor: UIColor.systemGray],
            for: .normal
        )
        
        control.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 18),
             .foregroundColor: UIColor.systemBlue],
            for: .selected
        )
        return control
    }()
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
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = historyButton
        navigationItem.backButtonTitle = "Back"
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
                self?.coordinator?.presentCreateViewController()
            }.disposed(by: bag)
        
        historyButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.coordinator?.pushHistoryViewController(button: self.historyButton)
            }.disposed(by: bag)
        
        segmentedControl
            .setAction { [weak self] oldIndex, index in
            guard let self = self else { return }
            let direction: UIPageViewController.NavigationDirection = oldIndex <= index ? .forward : .reverse
            self.pageViewController
                .setViewControllers(
                    [self.viewControllers[index]],
                    direction: direction,
                    animated: true
                )
        }
    }
}

extension PageViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        addChild(pageViewController)
        view.addSubview(segmentedControl)
        view.addSubview(pageViewController.view)
        
        segmentedControl.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(pageViewController.view.snp.top)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.pageViewController
            .setViewControllers(
                [viewControllers.first ?? UIViewController()],
                direction: .reverse,
                animated: true
            )

    }
}

extension PageViewController: UIPageViewControllerDataSource {
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

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool
    ) {
        guard let vc = pageViewController.viewControllers?[0],
              let index = viewControllers.firstIndex(of: vc) else { return }
        segmentedControl.selectedSegmentIndex = index
    }
}

extension PageViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
