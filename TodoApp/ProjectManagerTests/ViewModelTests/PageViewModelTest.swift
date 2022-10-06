//
//  PageViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/10/06.
//

import XCTest
@testable import ProjectManager

import RxSwift

final class PageViewModelTest: XCTestCase {
    var sut: DefaultPageViewModel!
    var useCase: MockUseCase!
    var bag: DisposeBag!
    

    override func setUpWithError() throws {
        useCase = MockUseCase()
        sut = DefaultPageViewModel(useCase: useCase)
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
        bag = nil
    }
    
    func test_Error가_발생했을때_sut가_올바른_Message를_방출해야한다() {
        // given
        
        // when
        sut.errorMessage
            .bind { output in
                // then
                XCTAssertEqual(output, TodoError.saveError.localizedDescription)
            }.disposed(by: bag)
    }
}
