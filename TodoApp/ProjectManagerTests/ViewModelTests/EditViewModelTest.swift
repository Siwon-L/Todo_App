//
//  TodoEditViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class EditViewModelTest: XCTestCase {
    var sut: DefaultEditViewModel!
    var useCase: MockUseCase!
    var item: TodoModel!
    var bag: DisposeBag!

    override func setUpWithError() throws {
        useCase = .init()
        item = TodoModel(title: "사파리", body: "사파리")
        sut = .init(useCase: useCase, item: item)
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        item = nil
        sut = nil
        bag = nil
    }
    
    func test_setUpView를_호출했을때_sut에_주입한_item과_동일한_output이_나와야한다() {
        // given
        let input = item
        
        // when
        sut.setUpView
            .bind { output in
                //then
                XCTAssertEqual(input, output)
            }.disposed(by: bag)
    }
   
    func test_editButtonDidTap호출시_setEditMode의_value값이_전환되어야한다() {
        // given
        let input = sut.setEditMode.value
        // when
        sut.editButtonDidTap()
        let output = sut.setEditMode.value
        // then
        XCTAssertEqual(!input, output)
    }
    
    func test_inputitle호출시_프로퍼티의_값으로_item의_title값이_수정되어야한다() {
        // given
        let newTitle = "newTitle"
        // when
        sut.inputitle(title: newTitle)
        sut.setUpView
            .bind { output in
                // then
                XCTAssertEqual(output.title, newTitle)
            }.disposed(by: bag)
    }
    
    func test_inputDeadline호출시_프로퍼티의_값으로_item의_deadlineAt값이_수정되어야한다() {
        // given
        let newDate = Date()
        // when
        sut.inputDeadline(deadline: newDate)
        sut.setUpView
            .bind { output in
                // then
                XCTAssertEqual(output.deadlineAt, newDate)
            }.disposed(by: bag)
    }
    
    func test_inputBody호출시_프로퍼티의_값으로_item의_body값이_수정되어야한다() {
        // given
        let newBody = "newBody"
        // when
        sut.inputBody(body: newBody)
        sut.setUpView
            .bind { output in
                // then
                XCTAssertEqual(output.body, newBody)
            }.disposed(by: bag)
    }
    
    func test_popView호출시_item이_수정되지_않았다면_UseCase의_updateItem메서드가_호출되지_않아야한다() {
        // given
        
        // when
        sut.popView()
        // then
        XCTAssertEqual(useCase.actions.count, 0)
    }
    
    func test_popView호출시_item이_수정되었다면_UseCase의_updateItem메서드가_호출되어야한다() {
        // given
        sut.inputitle(title: "newTitle")
        // when
        sut.popView()
        // then
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.first!, .update)
        sut.setUpView
            .bind { output in
                XCTAssertEqual(output.id, self.useCase.targetId)
            }.disposed(by: bag)
    }
}
