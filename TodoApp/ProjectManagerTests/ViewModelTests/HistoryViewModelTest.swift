//
//  HistoryViewModelTest.swift
//  ProjectManagerTests
//
//  Created by 이시원 on 2022/07/27.
//

import XCTest
import RxSwift
@testable import ProjectManager

class HistoryViewModelTest: XCTestCase {
    var useCase: MockUseCase!
    var sut: DefaultTodoHistoryViewModel!
    var bag: DisposeBag!
    var dummyData: [History]!
    
    override func setUpWithError() throws {
        bag = DisposeBag()
        dummyData = [
            .init(changes: .added, title: "todo"),
            .init(changes: .moved, title: "doing", beforeState: .todo, afterState: .doing),
            .init(changes: .removed, title: "done")
        ]
        useCase = MockUseCase(historyData: dummyData)
        sut = .init(useCase: useCase)
    }

    override func tearDownWithError() throws {
        useCase = nil
        sut = nil
        bag = nil
        dummyData = nil
    }
    
    func test_UseCase를_통해_HistoryItme을_읽어오는지() {
        // given
        
        // when
        sut.historyList
            .bind { cellItems in
                // then
                XCTAssertEqual(cellItems.count, self.dummyData.count)
            }.disposed(by: bag)
    }
}
