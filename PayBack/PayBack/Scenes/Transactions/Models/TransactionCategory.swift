//
//  TransactionCategory.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 02.02.23.
//

import UIKit
import Components

extension TransactionsResponseItem {
    enum CategoryType: Int, CaseIterable {
        case first = 1
        case second
        case third
        case removeFilters
    }
    
    var transactionCategory: CategoryType {
        return CategoryType(rawValue: self.category ?? 1) ?? .third
    }
}

extension TransactionsResponseItem.CategoryType {
    var icon: UIImage? {
        switch self {
        case .first:
            return UIImage(named: "ic_1")
        case .second:
            return UIImage(named: "ic_2")
        case .third:
            return UIImage(named: "ic_3")
        case .removeFilters:
            return UIImage(named: "ic_eat")
        }
    }
    
    var categoryName: String {
        switch self {
        case .first:
            return "First"
        case .second:
            return "Second"
        case .third:
            return "Third"
        case .removeFilters:
            return "Remove"
        }
    }
    
    var chips: StandardChipsCellViewModel {
        return .init(title: categoryName, state: .disabled)
    }
}
