//
//  TransactionDetail.swift
//  SimpleTransactions
//
//  Created by Sean Chen on 7/13/24.
//

import SwiftUI

/// A view that displays detailed information about a single transaction.
struct TransactionDetail: View {
    
    /// The transaction to be displayed in detail.
    let transaction: Transaction
    
    var body: some View {
        
        VStack {
            
            if transaction.debit > 0 {
                
                // Show debit amount in red
                Text(String(format: "+$%.2f", transaction.debit))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
                
            } else if transaction.credit > 0 {
                
                // Show credit amount in green
                Text(String(format: "-$%.2f", transaction.credit))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.green)
                
                // Display GST information for credit transactions
                Text(String(format: "Includes GST of $%.2f", transaction.credit * 0.15))
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            Text(transaction.summary)
            
            Text(dateString(transaction.transactionDate))
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("TransactionDetail")
    }
    
    /// Converts a Date object to a formatted string including both date and time.
    /// - Parameter date: The date to be formatted.
    /// - Returns: A string representation of the date and time in medium style.
    func dateString(_ date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
    }
}
