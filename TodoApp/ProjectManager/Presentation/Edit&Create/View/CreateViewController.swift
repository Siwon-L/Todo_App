//
//  CreateViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/26.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

protocol CreateViewControllerDependencies: AnyObject {
    func dismissCreateViewController()
}


final class CreateViewController: UIViewController {
    private enum Constant {
        static let create = "Create"
        static let cancel = "Cancel"
    }
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    private let createButton = UIBarButtonItem()
    private let bag = DisposeBag()
    private let mainView: CommonView = CreateView()
    private let viewModel: CreateViewModel
    private weak var coordinator: CreateViewControllerDependencies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    init(viewModel: CreateViewModel, coordinator: CreateViewControllerDependencies) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        guard let mainView = mainView as? CreateView else { return }
        createButton.title = Constant.create
        cancelButton.title = Constant.cancel
        mainView.navigationBar.items = [navigationItem]
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = createButton
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func bind() {
        mainView.rx.titleText
            .bind { [weak self] in
                self?.viewModel.inputitle(title: $0)
            }.disposed(by: bag)
        
        mainView.rx.datePicker
            .bind { [weak self] in
                self?.viewModel.inputDeadline(deadline: $0)
            }.disposed(by: bag)
        
        mainView.rx.bodyText
            .bind { [weak self] in
                self?.viewModel.inputBody(body: $0)
            }.disposed(by: bag)
        
        cancelButton.rx.tap
            .withUnretained(self)
            .bind { (self, _) in
                self.coordinator?.dismissCreateViewController()
            }.disposed(by: bag)
        
        createButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissCreateViewController()
                self?.viewModel.createButtonDidTap()
            }.disposed(by: bag)
    }
}
