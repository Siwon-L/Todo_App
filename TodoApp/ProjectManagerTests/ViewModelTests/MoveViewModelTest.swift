//
//  TodoMoveViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class MoveViewModelTest: XCTestCase {
    var sut: DefaultMoveViewModel!
    var useCase: MockUseCase!
    var bag: DisposeBag!
    
    override func setUpWithError() throws {
        useCase = MockUseCase()
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        useCase = nil
        bag = nil
    }

    func test_선택된_item의_State가_todo일때_올바른_ButtonTitle이_나오는지() {
        // given
        let itme = TodoModel(title: "todo", body: "todo", state: .todo)
        let fristButtonTitle = "Move to DOING"
        let secondButtonTitle = "Move to DONE"
        sut = .init(useCase: useCase, item: itme)
        
        // when
        sut.buttonTitle
            .bind { output in
                // then
                XCTAssertEqual(output[0], fristButtonTitle)
                XCTAssertEqual(output[1], secondButtonTitle)
            }.disposed(by: bag)
    }
  
    func test_선택된_item의_State가_doing일때_올바른_ButtonTitle이_나오는지() {
        // given
        let itme = TodoModel(title: "doing", body: "doing", state: .doing)
        let fristButtonTitle = "Move to TODO"
        let secondButtonTitle = "Move to DONE"
        sut = .init(useCase: useCase, item: itme)
        
        // when
        sut.buttonTitle
            .bind { output in
                // then
                XCTAssertEqual(output[0], fristButtonTitle)
                XCTAssertEqual(output[1], secondButtonTitle)
            }.disposed(by: bag)
    }

    func test_선택된_item의_State가_done일때_올바른_ButtonTitle이_나오는지() {
        // given
        let itme = TodoModel(title: "done", body: "done", state: .done)
        let fristButtonTitle = "Move to TODO"
        let secondButtonTitle = "Move to DOING"
        sut = .init(useCase: useCase, item: itme)
        
        // when
        sut.buttonTitle
            .bind { output in
                // then
                XCTAssertEqual(output[0], fristButtonTitle)
                XCTAssertEqual(output[1], secondButtonTitle)
            }.disposed(by: bag)
    }
   
    func test_firstButton을_Tap했을때_UseCase의_firstMoveState메서드를_호출하는지() {
        //given
        let item = TodoModel(title: "todo", body: "todo", state: .todo)
        sut = .init(useCase: useCase, item: item)
        
        // when
        sut.firstButtonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, item.id)
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .firstMove)
    }
    
    func test_secondButton을_Tap했을때_UseCase의_secondMoveState메서드를_호출하는지() {
        //given
        let item = TodoModel(title: "todo", body: "todo", state: .todo)
        sut = .init(useCase: useCase, item: item)
        
        // when
        sut.secondButtonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, item.id)
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .secondMove)
    }
    
    func test_deleltButton을_Tap했을때_UseCase의_deleteItem메서드를_호출하는지() {
        //given
        let item = TodoModel(title: "todo", body: "todo", state: .todo)
        sut = .init(useCase: useCase, item: item)
        
        // when
        sut.deleteButonDidTap()
        
        // then
        XCTAssertEqual(useCase.targetId, item.id)
        XCTAssertEqual(useCase.actions.count, 1)
        XCTAssertEqual(useCase.actions.last!, .delete)
    }
}
