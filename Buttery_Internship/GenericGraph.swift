//
//  GenericGraph.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/18/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

public struct GenericSummary: Identifiable {
    public let id = UUID()
    public let day: Date
    public let category: String
    public let cost: Double
}

public func MakeGenericGraph(
    groupBy category: (records) -> String = { _ in ""},
    metric: @escaping (records) -> Double,
    dayLimit: Int = 30
) -> [GenericSummary] {
    
    let formatter = ISO8601DateFormatter()
    
    struct GroupKey: Hashable {
        let day: String
        let category: String
    }
    
    let grouped = Dictionary(grouping: sampleData.records) { record -> GroupKey in
        GroupKey(day: record.day, category: category(record))
    }
    
    let summed = grouped.map {key, group -> GenericSummary in
        let date = formatter.date(from: key.day) ?? Date()
        let total  = group.reduce(0.0) {$0 + metric($1)}
        return GenericSummary(day: date, category: key.category, cost: total)
    }
    
    let uniqueDays = Set(summed.map { $0.day }).sorted().suffix(dayLimit)
    let dayLimitSet = Set(uniqueDays)
    
    return summed.filter{dayLimitSet.contains($0.day)}.sorted {$0.day < $1.day}
}

public struct GenericGraph: View {
    let data: [GenericSummary]
    let title: String
    let ylabel: String
    let dateRange: Int
    
    public init(data: [GenericSummary], title: String, ylabel: String, dateRange: Int) {
        self.data = data
        self.title = title
        self.ylabel = ylabel
        self.dateRange = dateRange
    }
    
    var limitedData: [GenericSummary] {
        Array(data.suffix(dateRange))
    }
    
    let graphDates = sampleData.records.map {$0.day}
    
    public var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding()
            Chart(data) { item in
                LineMark(
                    x: .value("date", item.day),
                    y: .value(ylabel, item.cost)
                ).foregroundStyle(by: .value("Catagory", item.category))
            }
            .chartXAxisLabel("Date", alignment: .center)
            
            .chartXAxis {
                AxisMarks(values: .automatic) { value in
                    AxisGridLine()
                    AxisTick()
                    if let date = value.as(Date.self) {
                        AxisValueLabel(anchor: .top) {
                            Text(date, format: .dateTime.month(.abbreviated).day())
                        }
                    }
                }
            }
            .chartYAxisLabel(ylabel, position: .trailing)
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 10))
            }
            .frame(width: 350, height: 200)
            .chartLegend(position: .top)
        }
    }
}

public struct GenericDataTable: View {
    let data: [GenericSummary]
    let title: String
    let category: String
    
    public init(data: [GenericSummary], title: String, category: String) {
        self.data = data
        self.title = title
        self.category = category
    }
    
    var hasCatagory: Bool {
        data.contains{!$0.category.isEmpty && $0.category != "Total"}
    }
    
    public var body: some View {
        VStack {
            Text(title).font(.headline)
            if hasCatagory {
                Table(data) {
                    TableColumn("Id") { item in Text("\(item.id)")}
                    TableColumn("Day") { item in
                        Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                    }
                    TableColumn(category) {item in Text("\(item.category)")}
                    TableColumn("Cost (Cents)") { item in
                        Text(String(format: "%.2f", item.cost))
                    }
                }
                .frame(width: 300, height: 200)
            } else {
                Table(data) {
                    TableColumn("Id") { item in Text("\(item.id)")}
                    TableColumn("Day") { item in
                        Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                    }
                    TableColumn("Cost (Cents)") { item in
                        Text(String(format: "%.2f", item.cost))
                    }
                }
                .frame(width: 300, height: 200)
            }
        }
    }
    
}
