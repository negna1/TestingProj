//
//  TransactionDetailsViewModel.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import Combine
import UIKit
import Components

protocol TransactionDetailsViewModelType {
    func transform(input: TransactionDetailsViewModelInput) -> TransactionDetailsViewModelOutput
}

struct TransactionDetailsViewModelInput {
    
}

typealias TransactionDetailsViewModelOutput = AnyPublisher<TransactionDetailsState, Never>

enum TransactionDetailsState: Equatable {
    case idle([TransactionDetailsController.CellModelType])
}

class TransactionDetailsViewModel: TransactionDetailsViewModelType {
    private typealias CellType = TransactionDetailsController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var currentDataSource: [CellType] = []
    private var title: String
    private var description: String
    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    func transform(input: TransactionDetailsViewModelInput) -> TransactionDetailsViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let idle: TransactionDetailsViewModelOutput = Just(.idle(idleVar))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return idle.eraseToAnyPublisher()
    }
    
    private var idleVar: [CellType] {
        [CellType.title(title, description)]
    }
}

extension TransactionDetailsViewModel {
    var getIdle: [TransactionDetailsController.CellModelType]  {
        idleVar
    }
}
