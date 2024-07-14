//
//  TransactionRow.swift
//  SimpleTransactions
//
//  Created by Sean Chen on 7/13/24.
//

import SwiftUI

/// A view that represents a single row in the transactions list.
struct TransactionRow: View {
    
    /// The transaction to be displayed in this row.
    let transaction: Transaction
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(transaction.summary)
                    .lineLimit(1)
                    .font(.title3)
                
                Text(dateString(transaction.transactionDate))
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            
            if transaction.debit > 0 {
                
                // Show debit amount in red
                Text(String(format: "+$%.2f", transaction.debit))
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
            } else if transaction.credit > 0 {
                
                // Show credit amount in green
                Text(String(format: "-$%.2f", transaction.credit))
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
        }
    }
    
    /// Converts a Date object to a formatted string.
    /// - Parameter date: The date to be formatted.
    /// - Returns: A string representation of the date in long style.
    func dateString(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        return formatter.string(from: date)
    }
}
