//
//  TransactionsView.swift
//  SimpleTransactions
//
//  Created by Sean Chen on 7/13/24.
//

import SwiftUI

/// The view that displays a list of transactions with sorting options.
struct TransactionsView: View {
    
    /// The view model that manages the transaction data and state.
    @ObservedObject private var viewModel = TransactionsViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            // Handle different states of the view
            switch viewModel.state {
                
            case .idle:
                
                Color.clear
                    .task {
                        Task {
                            await viewModel.fetchTransactions()
                        }
                    }
                
            case .loading:
                
                ProgressView()
                
            case .failed(let error):
                
                Text("\(error.localizedDescription)")
                    .padding()
                
                Button {
                    Task {
                        await viewModel.fetchTransactions()
                    }
                } label: {
                    Text("Retry")
                }
                
            case .loaded:
                
                List {
                    ForEach(viewModel.transactions) { transaction in
                        NavigationLink(value:transaction) {
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
                .navigationDestination(for: Transaction.self) { selection in
                    TransactionDetail(transaction: selection)
                }
                .navigationTitle("Transactions")
                .navigationBarItems(trailing: sortMenu)
                .accessibilityIdentifier("TransactionsList")
            }
        }
    }
    
    var sortMenu: some View {
        
        Menu {
            
            Button(action: {
                viewModel.sortTransactions(.id)
            }) {
                Text("Default Sorting")
            }
            
            Button(action: {
                viewModel.sortTransactions(.recentDate)
            }) {
                Text("Recent Transactions First")
            }
            
            Button(action: {
                viewModel.sortTransactions(.farthestDate)
            }) {
                Text("Farthest Transactions First")
            }
            
            Button(action: {
                viewModel.sortTransactions(.debit)
            }) {
                Text("Largest Debits First")
            }
            
            Button(action: {
                viewModel.sortTransactions(.credit)
            }) {
                Text("Largest Credits First")
            }
            
        } label: {
            
            Image(systemName: "arrow.up.arrow.down")
                .imageScale(.large)
        }
        .accessibilityLabel(Text("Transactions sorting button"))
    }
}

/// ViewModel for managing transactions data and state
@MainActor class TransactionsViewModel: ObservableObject {
    
    /// Represents the current state of the view
    enum State {
        case idle // Initial state: trigger data fetching
        case loading // Show loading indicator while fetching data
        case failed(Error) // Display error message and retry button if fetching fails
        case loaded // Display the list of transactions when data is loaded
    }
    
    /// Options for sorting transactions
    enum SortOption {
        case id
        case recentDate
        case farthestDate
        case debit
        case credit
    }
    
    @Published private(set) var state = State.idle
    
    @Published private(set) var transactions = [Transaction]()
    
    func fetchTransactions() async {
        
        do {
            
            state = .loading
            
            let url = URL(string: "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json")!
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            transactions = try await URLSession.shared.decode([Transaction].self, from: url, dateDecodingStrategy: .formatted(dateFormatter))
            
            state = .loaded
            
        } catch {
            
            state = .failed(error)
        }
    }
    
    /// Sorts the transactions based on the given option
    /// - Parameter option: The sorting option to apply
    func sortTransactions(_ option: SortOption) {
        
        switch option {
        case .id:
            transactions.sort { $0.id < $1.id }
        case .recentDate:
            transactions.sort { $0.transactionDate > $1.transactionDate }
        case .farthestDate:
            transactions.sort { $0.transactionDate < $1.transactionDate }
        case .debit:
            transactions.sort { $0.debit > $1.debit }
        case .credit:
            transactions.sort { $0.credit > $1.credit }
        }
    }
}

#Preview {
    TransactionsView()
}
