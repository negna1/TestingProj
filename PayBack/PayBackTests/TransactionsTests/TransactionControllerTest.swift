//
//  TransactionControllerTest.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//

import XCTest
@testable import PayBack
import Combine


final class TransactionControllerTest: XCTestCase {
    var vc: TransactionsController?
    override func setUpWithError() throws {
        vc = TransactionsController()
        let vm = TransactionViewModelMock()
        vc?.bind(with: vm)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTable() {
        XCTAssert(vc?.getTableView.numberOfRows(inSection: 0) == 0)
        
    }

    func testAfterViewDidLoad() {
        vc?.viewDidLoad()
        XCTAssertEqual(vc!.getDataSource.snapshot().numberOfItems, mockDataSource.snapshot().numberOfItems)
        
    }
    
    var mockDataSource: UITableViewDiffableDataSource<TransactionsController.Section,  TransactionsController.CellModelType> {
        let dt = UITableViewDiffableDataSource<TransactionsController.Section,  TransactionsController.CellModelType>.init(tableView: UITableView()) { tableView, indexPath, itemIdentifier in
            return UITableViewCell()
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<TransactionsController.Section,  TransactionsController.CellModelType>()
            snapshot.appendSections(TransactionsController.Section.allCases)
            snapshot.appendItems([TransactionsController.CellModelType.wholeTransaction(amount: 10, Currency: "GEL")], toSection: .initial)
            dt.apply(snapshot, animatingDifferences: false)
        return dt
    }
}
