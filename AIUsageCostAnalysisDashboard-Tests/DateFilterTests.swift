//
//  DateFilterTests.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import XCTest
@testable import Buttery_Internship
//MARK: DateFilter Tests
class DateFilterTests: XCTestCase {
    //MARK: Test File
    let mockFile = File(
            clusters: [clusters(id: "c1", name: "prod-us-west", region: "us-west-1")],
            nodes: [nodes(id: "n1", clusterId: "c1", name: "usw-large-01", size: "large")],
            models: [models(id: "m1", displayName: "Claude Sonnet", provider: "anthropic", isLocal: false)],
            records: [records(id: "r1", day: "2026-08-09T00:00:00Z", clusterId: "c1", nodeId: "n1",
                              queryType: "chat", modelId: "m1", queryCount: 100,
                              tokensIn: 1000, tokensOut: 500, totalDurationMs: 5000, costCents: 100.0),
                        records(id: "r2", day: "2026-08-10T00:00:00Z", clusterId: "c1", nodeId: "n1",
                                queryType: "chat", modelId: "m1", queryCount: 200,
                                tokensIn: 2000, tokensOut: 1000, totalDurationMs: 8000, costCents: 200.0),
                        records(id: "r3", day: "2026-08-11T00:00:00Z", clusterId: "c1", nodeId: "n1",
                                queryType: "search", modelId: "m1", queryCount: 50,
                                tokensIn: 500, tokensOut: 250, totalDurationMs: 2000, costCents: 50.0)]
        )
    
    var graphData: GraphDataSource!
    var appData: AppData!
    
    override func setUp() {
        graphData = GraphDataSource(provider: TestFileProvider(mockFile: mockFile))
        appData = AppData(source: graphData)
    }
    
    //MARK: Tests
    func testDateFilterChoices() {
        let all = appData.dateRangeFilter(option: .ninety, start: "", end: "")
        let thirty = appData.dateRangeFilter(option: .thirty, start: "", end: "")
        let seven = appData.dateRangeFilter(option: .seven, start: "", end: "")
        
        let allCount = graphData.records.filter(all).count
        let thirtyCount = graphData.records.filter(thirty).count
        let sevenCount = graphData.records.filter(seven).count
        
        XCTAssertLessThanOrEqual(thirtyCount, allCount, "Thirty days should be less than ninety days")
        XCTAssertLessThanOrEqual(sevenCount, allCount, "Seven days should be less than ninety days")
        XCTAssertLessThanOrEqual(sevenCount, thirtyCount, "Seven days should be less than thirty days")

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
        
        XCTAssertEqual(filtered.count, graphData.records.count, "Invalid custom dates should return all dates")
    }
}
