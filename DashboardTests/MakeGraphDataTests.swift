//
//  MakeGraphDataTests.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import XCTest
@testable import Buttery_Internship

//MARK: makeGenericGraph function tests
class MakeGenericGraphTests: XCTestCase {
    
    
        //MARK: Test Records
    let testRecords: [records] = [
        records(id: "1", day: "2026-08-09T00:00:00Z", clusterId: "c1", nodeId: "n1", queryType: "chat",
                modelId: "m1", queryCount: 500, tokensIn: 1000, tokensOut: 2000, totalDurationMs: 4566, costCents: 500.0),
        records(id: "2", day: "2026-08-10T00:00:00Z", clusterId: "c1", nodeId: "n1", queryType: "rome",
                modelId: "m1", queryCount: 436, tokensIn: 2575, tokensOut: 2577, totalDurationMs: 2356, costCents: 500.0),
        records(id: "2", day: "2026-08-11T00:00:00Z", clusterId: "c2", nodeId: "n2", queryType: "reya",
                modelId: "m2", queryCount: 756, tokensIn: 1532, tokensOut: 3467, totalDurationMs: 1354, costCents: 1000.0)
    
    ]
        //MARK: Test Dates
    let testSelectedDates: [String: Date] = {
        let formatter = ISO8601DateFormatter()
        return ["2026-08-09T00:00:00Z": formatter.date(from: "2026-08-09T00:00:00Z")!,
                "2026-08-10T00:00:00Z": formatter.date(from: "2026-08-10T00:00:00Z")!,
                "2026-08-11T00:00:00Z": formatter.date(from: "2026-08-11T00:00:00Z")!
        ]
    }()
        //MARK: Tests
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
