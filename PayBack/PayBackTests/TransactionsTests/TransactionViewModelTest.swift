//
//  TransactionViewModelTest.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//

import XCTest
@testable import PayBack
import Combine

final class TransactionViewModelTest: XCTestCase {
    var vc = TransactionsController()
    var vm: TransactionsViewModel?
    var categoryChangeMockPublisher =  PassthroughSubject<TransactionsResponseItem.CategoryType, Never>()
    var selectionMockPublisher =  PassthroughSubject<TransactionsController.CellModelType, Never>()
    private var cancellables: [AnyCancellable] = []
    override func setUpWithError() throws {
        vm = TransactionsViewModel(router: TransactionsRouterImpl(controller: vc))
        vc.bind(with: vm)
    }
    
    func testStates() {
        let input = TransactionsViewModelInput(
            categoryChange: categoryChangeMockPublisher.eraseToAnyPublisher(),
            selection: selectionMockPublisher.eraseToAnyPublisher())
        vm?.transform(input: input).sink(receiveValue: {state in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                XCTAssertEqual(state, .idle([.wholeTransaction(amount: 1, Currency: "1")]))
            }
        }).store(in: &cancellables)
        vm?.getStateSubject.send(.idle([.wholeTransaction(amount: 1, Currency: "1")]))
    }
    
    func testCategoryChange() {
        let input = TransactionsViewModelInput(
            categoryChange: categoryChangeMockPublisher.eraseToAnyPublisher(),
            selection: selectionMockPublisher.eraseToAnyPublisher())
        categoryChangeMockPublisher.send(.first)
        vm?.getInput?.categoryChange.sink(receiveValue: { type in
            XCTAssertEqual(type, .first)
        }).store(in: &cancellables)
    }
    
    func testSelectionChange() {
        let input = TransactionsViewModelInput(
            categoryChange: categoryChangeMockPublisher.eraseToAnyPublisher(),
            selection: selectionMockPublisher.eraseToAnyPublisher())
        selectionMockPublisher.send(.wholeTransaction(amount: 1, Currency: "1"))
        vm?.getInput?.selection.sink(receiveValue: { selection in
            XCTAssertEqual(selection, .wholeTransaction(amount: 1, Currency: "1"))
        }).store(in: &cancellables)
    }
    
    func testErrorCase() {
        let input = TransactionsViewModelInput(
            categoryChange: categoryChangeMockPublisher.eraseToAnyPublisher(),
            selection: selectionMockPublisher.eraseToAnyPublisher())
        vm?.transform(input: input).sink(receiveValue: {state in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                XCTAssertEqual(state, .showError("Error"))
            }
        }).store(in: &cancellables)
        vm?.getStateSubject.send(.showError("Error"))
    }
}
