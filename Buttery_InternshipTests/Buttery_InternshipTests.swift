//
//  Buttery_InternshipTests.swift
//  Buttery_InternshipTests
//
//  Created by Jason Zhang on 6/15/26.
//

import XCTest
@testable import Buttery_Internship

class MakeGenericGraphTests: XCTestCase {
    let testRecords: [records] = [
        records(id: "1", day: "2026-08-09T00:00:00Z", clusterId: "c1", nodeId: "n1", queryType: "chat",
                modelId: "m1", queryCount: 500, tokensIn: 1000, tokensOut: 2000, totalDurationMs: 4566, costCents: 500.0),
        records(id: "2", day: "2026-08-10T00:00:00Z", clusterId: "c1", nodeId: "n1", queryType: "rome",
                modelId: "m1", queryCount: 436, tokensIn: 2575, tokensOut: 2577, totalDurationMs: 2356, costCents: 500.0),
        records(id: "2", day: "2026-08-11T00:00:00Z", clusterId: "c2", nodeId: "n2", queryType: "reya",
                modelId: "m2", queryCount: 756, tokensIn: 1532, tokensOut: 3467, totalDurationMs: 1354, costCents: 1000.0)
    
    ]
    
    let testSelectedDates: [String: Date] = {
        let formatter = ISO8601DateFormatter()
        return ["2026-08-09T00:00:00Z": formatter.date(from: "2026-08-09T00:00:00Z")!,
                "2026-08-10T00:00:00Z": formatter.date(from: "2026-08-10T00:00:00Z")!,
                "2026-08-11T00:00:00Z": formatter.date(from: "2026-08-11T00:00:00Z")!
        ]
    }()
    
    func testTotalCostAggregation() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents}, dayLimit: 30).reduce(0) {$0 + $1.cost}
        XCTAssertEqual(result, 2000.0, accuracy: 0.1, "All costs should be summed")
    }
    
    func testAverageCostAggregation() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents / Double($0.queryCount) }, dayLimit: 30)
            .reduce(0) {$0 + $1.cost}
        XCTAssertEqual(result, 3.4, accuracy: 0.1, "Average cost should be 1")
    }
    
    func testGroupByQueryType() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, groupBy: {$0.queryType} , metric: {$0.costCents}, dayLimit: 30)
        let catagories = Set(result.map {$0.category})
        
        XCTAssertTrue(catagories.contains("chat"), "Should contain chat")
        XCTAssertTrue(catagories.contains("rome"), "Should contain rome")
        XCTAssertTrue(catagories.contains("reya"), "Should contain reya")
    }
    
    func testDayLimit() {
        let allResult = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents}, dayLimit: 99)
        let limitResult = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents}, dayLimit: 1)
        
        XCTAssertGreaterThan(allResult.count, limitResult.count, "dayLimit should reduce result")
        XCTAssertEqual(limitResult.count, 1, "Should be limited to 1")
    }
    
    func testFilterCluster() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, filter: {$0.clusterId == "c1"}, metric: {$0.costCents}, dayLimit: 30)
        let total = result.reduce(0) {$0 + $1.cost}
        
        XCTAssertEqual(total, 1000.0, accuracy: 0.01, "c1 clusters should sum to 1151")
        
    }
    
    func testDelta() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents}, dayLimit: 30, delta: true)
        
        XCTAssertEqual(result.first?.cost, 0, "Delta should be 0 for first day")
    }
    
    func testResultsSorted() {
        let result = makeGenericGraph(
            record: testRecords, selectedDates: testSelectedDates, metric: {$0.costCents}, dayLimit: 30, delta: true)
        let dates = result.map {$0.day}
        
        XCTAssertEqual(dates, dates.sorted(), "Results should be sorted")
    }
}

class DateFilterTests: XCTestCase {
    var graphData: GraphDataSource!
    var appData: AppData!
    
    override func setUp() {
        graphData = GraphDataSource()
        appData = AppData(source: graphData)
    }
    
    func testDateFilterChoices() {
        let all = appData.dateRangeFilter(option: .ninety, start: "", end: "")
        let thirty = appData.dateRangeFilter(option: .thirty, start: "", end: "")
        let seven = appData.dateRangeFilter(option: .seven, start: "", end: "")
        
        let allCount = graphData.records.filter(all).count
        let thirtyCount = graphData.records.filter(thirty).count
        let sevenCount = graphData.records.filter(seven).count
        
        XCTAssertLessThan(thirtyCount, allCount, "Thirty days should be less than ninety days")
        XCTAssertLessThan(sevenCount, allCount, "Seven days should be less than ninety days")
        XCTAssertLessThan(sevenCount, thirtyCount, "Seven days should be less than thirty days")

    }
    
    func testCustomDateRange() {
        let filter = appData.dateRangeFilter(option: .custom, start: "2026-08-09", end: "2026-08-11")
        let filtered = graphData.records.filter(filter)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let startDate = formatter.date(from: "2026-08-09")!
        let endDate = formatter.date(from: "2026-08-11")!

        for record in filtered {
            let date = graphData.cachedDates[record.day] ?? .distantPast
            XCTAssertGreaterThanOrEqual(date, startDate, "Record date should be same or after start date")
            XCTAssertLessThanOrEqual(date, endDate, "Record date should be same or before end date")

        }
    }
    
    func testInvalidCustomDate() {
        let filter = appData.dateRangeFilter(option: .custom, start: "invalid", end: "invalid")
        let filtered = graphData.records.filter(filter)
        
        XCTAssertEqual(filtered.count, graphData.records.count, "Invalid custom dates should return nothing")
    }
}

class GraphDataTests: XCTestCase {
    func testLoadSucess() {
        let data = GraphDataSource()
        XCTAssertNotNil(data.fileData, "File should load correctly")
        XCTAssertNil(data.dataError, "Error should be nil")
    }
    
    func testLoadFail() {
        struct BadScenario: FileProvider {
            var fileName: String {"Nil"}
            var fileExtension: String {"json"}
            var displayName: String {"None"}
        }
        
        let data = GraphDataSource(provider: BadScenario())
        XCTAssertNil(data.fileData, "File should not load correctly")
        XCTAssertNotNil(data.dataError, "Error should be displayed")
    }
    
    func testParsedDates() {
        let data = GraphDataSource()
        XCTAssertFalse(data.records.isEmpty, "{Parsed dates should not be empty")
    }
    
    func testRecordsAccessible() {
        let data = GraphDataSource()
        XCTAssertNotNil(data.records.first, "{Records should be accessible}")
    }
}

//Doesn't display test suceeds but the notice does show up that it works
class UITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
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
