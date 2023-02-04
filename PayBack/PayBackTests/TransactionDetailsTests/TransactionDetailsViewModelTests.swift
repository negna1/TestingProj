//
//  TransactionDetailsViewModelTests.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//

import XCTest
@testable import PayBack
import Combine

final class TransactionDetailsViewModelTests: XCTestCase {
    var vc = TransactionDetailsController()
    var vm: TransactionDetailsViewModel?
    private var cancellables: [AnyCancellable] = []
    override func setUpWithError() throws {
        vm = TransactionDetailsViewModel(title: "title",
                                         description: "description")
        vc.bind(with: vm)
    }
    
    func testStates() {
        let input = TransactionDetailsViewModelInput()
        vm?.transform(input: input).sink(receiveValue: {state in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertEqual(state, .idle([.title("title", "description")]))
            }
            
        }).store(in: &cancellables)
    }
}
