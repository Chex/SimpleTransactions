//
//  SimpleTransactionsTests.swift
//  SimpleTransactionsTests
//
//  Created by Sean Chen on 7/13/24.
//

import XCTest
@testable import SimpleTransactions

final class SimpleTransactionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Tests the fetchTransactions method of TransactionsViewModel.
    @MainActor func testFetchTransactions() async {
        
        let viewModel = TransactionsViewModel()
        
        let expectation = XCTestExpectation(description: "Fetch transactions")
        
        // Perform the fetch operation
        Task {
            await viewModel.fetchTransactions()
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled, with a timeout
        await fulfillment(of: [expectation], timeout: 8.0)
        
        // Assert that transactions were fetched
        XCTAssertFalse(viewModel.transactions.isEmpty, "Transactions should not be empty")
    }
}
