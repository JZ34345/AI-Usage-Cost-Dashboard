//
//  ModelGraph.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData
import PlaygroundSupport

// MARK: Graph 4 Structure
public struct graph4Summary: Identifiable, Sendable {
    public let id = UUID()
    public let day: Date
    public let modelId: String
    public let costCents: Double
}

public func makeGraph4Data() -> [graph4Summary] {
    let formatter = ISO8601DateFormatter()
    
    struct groupKey: Hashable {
        let day: String
        let modelId: String
    }
    
    let graph4Grouped = Dictionary(grouping: sampleData.records) {record -> groupKey in
        return groupKey(day: record.day, modelId: record.modelId)
    }

    let graph4Aggregated = graph4Grouped.map { key, group -> graph4Summary in
        let date = formatter.date(from: key.day) ?? Date()
        let total = group.reduce(0.0) {$0 + $1.costCents}
        return graph4Summary(day: date, modelId: key.modelId, costCents: total)
    }
    
    let graph4Data = graph4Aggregated.sorted { $0.day < $1.day }
    return graph4Data.suffix(30)
}

let graph4Data = makeGraph4Data()

//MARK: Graph4 View
public struct Graph4: View {
    public init() {}
    let graph4Dates = graph4Data.map { $0.day }
    public var body: some View {
        VStack {
            Text("Model Cost-Time Graph (2026)")
                .font(.headline)
                .padding()
            Chart(graph4Data) { item in
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Cost in Cents", item.costCents)
                ).foregroundStyle(by: .value("Model", item.modelId))
            }
            .chartXAxisLabel("Date", alignment: .center)
            .chartYAxisLabel("Cost (Cents)", position: .trailing)
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
            .frame(width: 400, height: 200)
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 10))
            }
            .frame(width: 400, height: 200)
            .chartLegend(position: .top)
        }
    }
}
//MARK: Database 4
public struct DataTable4: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("Total Cost-Time Table").font(.headline)
            Table(graph4Data) {
                TableColumn("Id") { item in Text("\(item.id)")}
                TableColumn("ModelId") { item in Text("\(item.modelId)")}
                TableColumn("Day") { item in
                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                }
                TableColumn("Cost (Cents)") { item in
                    Text(String(format: "%.2f", item.costCents))
                }
            }
            .frame(width: 350, height: 200)
        }
    }
}



