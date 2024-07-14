//
//  Transaction.swift
//  SimpleTransactions
//
//  Created by Sean Chen on 7/13/24.
//

import Foundation

/// Represents a single financial transaction.
struct Transaction: Codable, Identifiable, Hashable {
    let id: Int
    let transactionDate: Date
    let summary: String
    let debit: Double
    let credit: Double
}
