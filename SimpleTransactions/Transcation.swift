//
//  Transcation.swift
//  SimpleTranscations
//
//  Created by 陈曦 on 7/10/24.
//

import Foundation

struct Transaction: Codable, Identifiable, Hashable {
    let id: Int
    let transactionDate: Date
    let summary: String
    let debit: Double
    let credit: Double
}
