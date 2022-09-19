//
//  PopoverViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/13.
//

import UIKit
import SnapKit
import RxSwift

protocol TodoMoveViewControllerDependencies: AnyObject {
    func dismissMoveViewController()
}

enum ArrowDirections {
    case up
    case down
}

final class TodoMoveViewController: UIViewController {
    private let viewModel: TodoMoveViewModel
    private weak var coordinator: TodoMoveViewControllerDependencies?
    var arrowDirections: ArrowDirections?
    private let bag = DisposeBag()
    
    private let firstButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let secondButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitleColor(UIColor.systemRed, for: .normal)
        return button
    }()
    
    private lazy var buttomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstButton, secondButton, deleteButton])
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemGray4
        return stackView
    }()
    
    init(viewModel: TodoMoveViewModel, coordinator: TodoMoveViewControllerDependencies) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }
}

//MARK: - View Setting
extension TodoMoveViewController {
    private func configureView() {
        view.backgroundColor = .systemGray5
        view.addSubview(buttomStackView)
        buttomStackView.snp.makeConstraints { make in
            if arrowDirections == .up {
                make.top.equalToSuperview().inset(12)
                make.bottom.leading.trailing.equalToSuperview()
            } else {
                make.bottom.equalToSuperview().inset(12)
                make.top.leading.trailing.equalToSuperview()
            }
            
        }
    }
}

//MARK: - ViewModel Bind
extension TodoMoveViewController {
    private func bind() {
        viewModel.buttonTitle
            .bind { [weak self] in
                self?.firstButton.setTitle($0[0], for: .normal)
                self?.secondButton.setTitle($0[1], for: .normal)
                self?.deleteButton.setTitle("Delete", for: .normal)
            }.disposed(by: bag)
        
        firstButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissMoveViewController()
                self?.viewModel.firstButtonDidTap()
            }.disposed(by: bag)
        
        secondButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissMoveViewController()
                self?.viewModel.secondButtonDidTap()
            }.disposed(by: bag)
        
        deleteButton.rx.tap
            .bind { [weak self] in
                self?.coordinator?.dismissMoveViewController()
                self?.viewModel.deleteButonDidTap()
            }.disposed(by: bag)
    }
}
