//
//  EditViewController.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/07/08.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class EditViewController: UIViewController {
    private enum Constant {
        static let edit = "Edit"
        static let eidting = "Editing"
    }
    
    private let mainView: CommonView = EditView()
    private let viewModel: EditViewModel
    private let bag = DisposeBag()
    
    private let editButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.popView()
    }
    
    init(viewModel: EditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - View Setting
extension EditViewController {
    private func configureUI() {
        editButton.title = Constant.edit
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = editButton
        
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - ViewModel Bind
extension EditViewController {
    private func bind() {
        viewModel.setUpView
            .bind { [weak self] in
                self?.mainView.setupView(by: $0)
            }.disposed(by: bag)
        
        viewModel.setEditMode
            .bind { [weak self] in
                self?.mainView.setEnabled($0)
                self?.editButton.title = $0 ? Constant.eidting : Constant.edit
            }.disposed(by: bag)
        
        editButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.editButtonDidTap()
            }.disposed(by: bag)
        
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
    }
}
