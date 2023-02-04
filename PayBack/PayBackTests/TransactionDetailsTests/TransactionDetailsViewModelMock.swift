//
//  TransactionDetailsViewModelMock.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//

@testable import PayBack
import Combine
import XCTest

class TransactionDetailsViewModelMock: TransactionDetailsViewModelType {
    private typealias CellType = TransactionDetailsController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var currentDataSource: [CellType] = []
    
    func transform(input: TransactionDetailsViewModelInput) -> TransactionDetailsViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let idle: TransactionDetailsViewModelOutput = Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return idle.eraseToAnyPublisher()
    }
    
    private var idleModels: [CellType] {
        let totalCommission = CellType.title("1", "2")
        return [totalCommission]
    }
}
