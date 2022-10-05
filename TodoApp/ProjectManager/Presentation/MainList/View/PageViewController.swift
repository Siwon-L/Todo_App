//
//  PageViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/13.
//

import UIKit

import SnapKit
import RxSwift
import CustomUIKit

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
    private let segmentedControl: CUISegmentControl = {
        let control = CUISegmentControl(
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
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.bounces = false
        scrollView.decelerationRate = .fast
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
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
        configureUI()
        configureNavigationBar()
        bind()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = plusButton
        navigationItem.leftBarButtonItem = historyButton
        navigationItem.backButtonTitle = "Back"
        historyButton.image = UIImage(systemName: "clock")
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
            .setAction { [weak self] index in
                guard let self = self else { return }
                self.scrollView.setContentOffset(
                    CGPoint(
                        x: self.view.frame.width * Double(index),
                        y: 0
                    )
                    , animated: true
                )
            }
    }
}

extension PageViewController {
    private func configureUI() {
        view.backgroundColor = .systemBackground
        scrollView.contentSize.width = view.frame.width * Double(viewControllers.count)
        view.addSubview(segmentedControl)
        view.addSubview(scrollView)
        scrollView.delegate = self
        
        segmentedControl.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(scrollView.snp.top)
            $0.height.equalToSuperview().multipliedBy(0.05)
        }
        
        scrollView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        Array(0..<viewControllers.count).forEach { index in
            let vc = viewControllers[index]
            addChild(vc)
            scrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: view.frame.width * Double(index), y: 0, width: 0, height: 0)
            vc.didMove(toParent: self)
        }
    }
}

extension PageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xxx = scrollView.contentOffset.x / view.frame.width
        if scrollView.isTracking {
            segmentedControl.xxx(xxx)
        }
    }
    
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let xPoint = targetContentOffset.pointee.x
        
        targetContentOffset.pointee.x = round(xPoint / view.frame.width) * view.frame.width
        
        let selectedIndex = targetContentOffset.pointee.x / view.frame.width
        segmentedControl.currentIndex = Int(selectedIndex)
    }
}



extension PageViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
