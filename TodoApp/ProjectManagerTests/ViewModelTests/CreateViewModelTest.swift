//
//  CreateViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/10/02.
//

import XCTest
@testable import ProjectManager

import RxSwift

final class CreateViewModelTest: XCTestCase {
    var sut: DefaultCreateViewModel!
    var useCase: MockUseCase!
    var item: TodoModel!
    var bag: DisposeBag!
    
    override func setUpWithError() throws {
        useCase = MockUseCase()
        item = TodoModel()
        sut = DefaultCreateViewModel(useCase: useCase, item: item)
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
        item = nil
        bag = nil
    }
    
    func test_createButtonDidTap호출시_title과_body입력이_없으면_useCase의_createItem메서드가_호출되지_않아야한다() {
        // given
        sut.inputitle(title: "")
        sut.inputBody(body: "")
        // when
        sut.createButtonDidTap()
        // then
        XCTAssertEqual(useCase.actions.count, 0)
    }
    
    func test_createButtonDidTap호출시_title입력하면_useCase의_createItem메서드가_호출되어야한다() {
        // given
        sut.inputitle(title: "title")
        sut.inputBody(body: "")
        // when
        sut.createButtonDidTap()
        // then
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .create)
        XCTAssertEqual(useCase.targetId, item.id)
    }
    
    func test_createButtonDidTap호출시_body입력하면_useCase의_createItem메서드가_호출되어야한다() {
        // given
        sut.inputitle(title: "")
        sut.inputBody(body: "body")
        // when
        sut.createButtonDidTap()
        // then
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .create)
        XCTAssertEqual(useCase.targetId, item.id)
    }
    
    func test_createButtonDidTap호출시_title과_body입력하면_useCase의_createItem메서드가_호출되어야한다() {
        // given
        sut.inputitle(title: "title")
        sut.inputBody(body: "body")
        // when
        sut.createButtonDidTap()
        // then
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .create)
        XCTAssertEqual(useCase.targetId, item.id)
    }
}
