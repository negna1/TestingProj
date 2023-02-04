//
//  TransactionViewModelMock.swift
//  PayBackTests
//
//  Created by Nato Egnatashvili on 03.02.23.
//


@testable import PayBack
import Combine
import XCTest

class TransactionViewModelMock: TransactionsViewModelType {
    private typealias CellType = TransactionsController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<TransactionsState, Never>()
    private var currentDataSource: [CellType] = []
    
    func transform(input: TransactionsViewModelInput) -> TransactionsViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        
        currentDataSource = idleModels
        let idle: TransactionsViewModelOutput = Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return Publishers.Merge(idle, stateSubject).removeDuplicates().eraseToAnyPublisher()
    }
    
    private var idleModels: [CellType] {
        let totalCommission = CellType.wholeTransaction(amount: 10, Currency: "GEL")
        return [totalCommission]
    }
    
}
