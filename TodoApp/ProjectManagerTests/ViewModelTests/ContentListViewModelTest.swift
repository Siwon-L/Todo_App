//
//  MockUseCase.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/26.
//

import XCTest
import RxSwift
@testable import ProjectManager

class ContentListViewModelTest: XCTestCase {
    var sut: ContentListViewModel!
    var useCase: MockUseCase!
    var bag: DisposeBag!
    var dummyData: [TodoModel]!

    override func setUpWithError() throws {
        bag = DisposeBag()
        dummyData = [
            .init(title: "todo", body: "todo", state: .todo),
            .init(title: "doing", body: "doing", state: .doing),
            .init(title: "done", body: "done", state: .done),
        ]
        useCase = .init(listData: dummyData)
    }

    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
        bag = nil
        dummyData = nil
    }
    
    func test_contentList를_호출했을때_dummy의_state가_todo인_item과_동일한_title을_가진_output이_나와야한다() {
        // given
        let targetState: State = .todo
        sut = DefaultContentListViewModel(useCase: useCase, targetState: targetState)
        let input = dummyData.filter { $0.state == targetState }
        // when
        sut.contentList
            .bind { output in
                // then
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
                XCTAssertEqual(input.first!.title, output.first!.title)
            }.disposed(by: bag)
        
        
    }
    
    func test_contentList를_호출했을때_dummy의_state가_doing인_item과_동일한_title을_가진_output이_나와야한다() {
        // given
        let targetState: State = .doing
        sut = DefaultContentListViewModel(useCase: useCase, targetState: targetState)
        let input = dummyData.filter { $0.state == targetState }
        // when
        sut.contentList
            .bind { output in
                // then
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
                XCTAssertEqual(input.first!.title, output.first!.title)
            }.disposed(by: bag)
        
        
    }
    
    func test_contentList를_호출했을때_dummy의_state가_done인_item과_동일한_title을_가진_output이_나와야한다() {
        // given
        let targetState: State = .done
        sut = DefaultContentListViewModel(useCase: useCase, targetState: targetState)
        let input = dummyData.filter { $0.state == targetState }
        // when
        sut.contentList
            .bind { output in
                // then
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
                XCTAssertEqual(input.first!.title, output.first!.title)
            }.disposed(by: bag)
        
        
    }
    
    func test_contentCount를_호출했을때_targetState가_todo인_sut에서는_output이_1이_나와야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .todo)
        
        // when
        sut.contentCount
            .drive { output in
                // then
                XCTAssertEqual(output, "1")
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
            }.disposed(by: bag)
    }
  
    func test_contentCount를_호출했을때_targetState가_doing인_화면에서는_output이_1이_나와야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .doing)
        
        // when
        sut.contentCount
            .drive { output in
                // then
                XCTAssertEqual(output, "1")
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
            }.disposed(by: bag)
    }
    
    func test_contentCount를_호출했을때_targetState가_done인_화면에서는_output이_1이_나와야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .done)
        
        // when
        sut.contentCount
            .drive { output in
                // then
                XCTAssertEqual(output, "1")
                XCTAssertEqual(self.useCase.actions.count, 1)
                XCTAssertEqual(self.useCase.actions.first, .readItems)
            }.disposed(by: bag)
    }
    
    func test_listTitle를_호출했을때_targetState가_todo이면_output이_TODO여야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .todo)
        // when
        sut.listTitle
            .drive { output in
                // then
                XCTAssertEqual(output, "TODO")
            }.disposed(by: bag)
        
    }
    
    func test_listTitle를_호출했을때_targetState가_doing이면_output이_DOING여야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .doing)
        // when
        sut.listTitle
            .drive { output in
                // then
                XCTAssertEqual(output, "DOING")
            }.disposed(by: bag)
        
    }
    
    func test_listTitle를_호출했을때_targetState가_done_output이_DONE여야한다() {
        // given
        sut = DefaultContentListViewModel(useCase: useCase, targetState: .done)
        // when
        sut.listTitle
            .drive { output in
                // then
                XCTAssertEqual(output, "DONE")
            }.disposed(by: bag)
    }
    
    func test_cellSelected를_호출했을때_id를_통해_input과_동일한_output이_반환되어야_한다() {
        // given
        let targetState: State = .todo
        sut = DefaultContentListViewModel(useCase: useCase, targetState: targetState)
        let input = dummyData.first { $0.state == targetState }!
        
        // when
        let output = sut.cellSelected(id: input.id)
            
        // then
        XCTAssertEqual(self.useCase.actions.count, 1)
        XCTAssertEqual(self.useCase.actions.first!, .readItems)
        XCTAssertEqual(input, output)
    }
}

