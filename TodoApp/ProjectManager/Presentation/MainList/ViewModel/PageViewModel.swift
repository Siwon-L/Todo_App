//
//  PageViewModel.swift
//  ProjectManager
//
//  Created by 이시원 on 2022/09/16.
//

import Foundation

import RxSwift

protocol PageViewModelInput {}

protocol PageViewModelOutput {
    var errorMessage: Observable<String> { get }
}

protocol PageViewModel: PageViewModelInput, PageViewModelOutput {}

final class DefaultPageViewModel {
    private let useCase: TodoListUseCase

    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
}

extension DefaultPageViewModel: PageViewModel {
    var errorMessage: Observable<String> {
        useCase.errorObserver
            .map { error in
                error.localizedDescription
            }
    }
}
