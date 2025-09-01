//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by Jakub Błażowski on 21/08/2025.
//

import XCTest

final class ToDoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveButtonDisabledWithoutTitle_andEnabledAfterTyping() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addTaskButton"].tap()

        let saveButton = app.buttons["Save"]
        XCTAssertFalse(saveButton.isEnabled)

        let titleField = app.textFields["Add title"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("UI Smoke Task")

        XCTAssertTrue(saveButton.isEnabled)
        app.buttons["Back"].tap()
    }

    func testAddTaskAndSeeItOnAllTasks() {
        let app = XCUIApplication()
        app.launch()

        app.buttons["addTaskButton"].tap()

        let title = "UITask \(Int(Date().timeIntervalSince1970))"
        let titleField = app.textFields["Add title"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText(title)

        app.buttons["Save"].tap()
        app.tabBars.buttons["All tasks"].tap()

        let cellTitle = app.staticTexts[title]
        XCTAssertTrue(cellTitle.waitForExistence(timeout: 3))
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
