//
//  UITests.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import XCTest
@testable import Buttery_Internship

//MARK: App UI Tests
//Tests whether the filters and buttons load in properly after app launches.
//Doesn't display test suceeds but the notice does show up that it works.
class UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
        //MARK: Tests
    func testFilterExist() {
        XCTAssertTrue(app.buttons["Total"].isEnabled, "Filter button should be ready for use")
    }
    
    func testDateFilterExist() {
        XCTAssertTrue(app.buttons["7 Days"].isEnabled, "Date filter should be ready for use")
    }
    
    func testExportExist() {
        XCTAssertTrue(app.buttons["Export File"].isEnabled, "Export should be ready for use")
    }
}
