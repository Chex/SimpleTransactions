//
//  SimpleTransactionsUITests.swift
//  SimpleTransactionsUITests
//
//  Created by Sean Chen on 7/13/24.
//

import XCTest

final class SimpleTransactionsUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTransactionSelection() throws {
        
        let list = app.collectionViews["TransactionsList"]
        
        // Set up an expectation for the list to appear.
        let listExistsPredicate = NSPredicate(format: "exists == true")
        let listExpectation = expectation(for: listExistsPredicate, evaluatedWith: list, handler: nil)
        let listResult = XCTWaiter.wait(for: [listExpectation], timeout: 8.0)
        
        // Assert that the list loaded successfully.
        XCTAssertEqual(listResult, .completed, "List should load within 8 seconds")
        XCTAssertGreaterThan(list.cells.count, 0, "List should have at least one cell")
        
        // Tap the first cell in the list.
        let firstCell = list.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell should exist")
        firstCell.tap()
        
        let detail = app.otherElements["TransactionDetail"]
        
        // Set up an expectation for the transcation detail to appear.
        let detailExistsPredicate = NSPredicate(format: "exists == true")
        let detailExpectation = expectation(for: detailExistsPredicate, evaluatedWith: detail, handler: nil)
        let detailResult = XCTWaiter.wait(for: [detailExpectation], timeout: 2.0)
        
        // Assert that the transcation detail loaded successfully.
        XCTAssertEqual(detailResult, .completed, "Transaction Detail should load within 2 seconds")
    }
}
