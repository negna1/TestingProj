//
//  TransactionDetailsController.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//

import XCTest
@testable import PayBack
import Combine


final class TransactionDetailsControllerTests: XCTestCase {
    var vc: TransactionDetailsController?
    override func setUpWithError() throws {
        vc = TransactionDetailsController()
        let vm = TransactionDetailsViewModelMock()
        vc?.bind(with: vm)
    }
    
    func testTable() {
        XCTAssert(vc?.getTableView.numberOfRows(inSection: 0) == 0)
    }
    
    func testAfterViewDidLoad() {
        vc?.viewDidLoad()
        XCTAssertEqual(vc!.getDataSource.snapshot().numberOfItems, mockDataSource.snapshot().numberOfItems)
        
    }
    
    var mockDataSource: UITableViewDiffableDataSource<TransactionDetailsController.Section,  TransactionDetailsController.CellModelType> {
        var dt =  UITableViewDiffableDataSource<TransactionDetailsController.Section,  TransactionDetailsController.CellModelType> .init(tableView: UITableView()) { tableView, indexPath, itemIdentifier in
            return UITableViewCell()
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<TransactionDetailsController.Section,  TransactionDetailsController.CellModelType>()
        snapshot.appendSections(TransactionDetailsController.Section.allCases)
        snapshot.appendItems([TransactionDetailsController.CellModelType.title("1", "2")], toSection: .initial)
        dt.apply(snapshot)
        return dt
    }
}
