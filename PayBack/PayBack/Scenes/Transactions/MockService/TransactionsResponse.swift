//
//  TransactionsResponse.swift
//  PayBack
//
//  Created by Nato Egnatashvili on 01.02.23.
//

import Foundation

// MARK: - Welcome
struct TransactionsResponse: Codable {
    let items: [TransactionsResponseItem]?
}

// MARK: - Item
struct TransactionsResponseItem: Codable {
    let partnerDisplayName: String?
    let alias: Alias?
    let category: Int?
    let transactionDetail: TransactionDetail?
}

// MARK: - Alias
struct Alias: Codable {
    let reference: String?
}

// MARK: - TransactionDetail
struct TransactionDetail: Codable {
    let description: String?
    let bookingDate: String?
    let value: Value?
}

enum Description: String, Codable {
    case punkteSammeln = "Punkte sammeln"
}

// MARK: - Value
struct Value: Codable {
    let amount: Double?
    let currency: String?
}
