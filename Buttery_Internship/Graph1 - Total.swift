//
//  Graph1.swift
//  
//
//  Created by Jason Zhang on 6/16/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

let data = sampleData

// MARK: Graph 1 Structure
public struct graph1Summary: Identifiable, Sendable {
    public let id = UUID()
    public let day: Date
    public let costCents: Double
}

public func makeGraph1Data() -> [graph1Summary] {
    let formatter = ISO8601DateFormatter()
    let graph1Grouped = Dictionary(grouping: data.records, by: { $0.day })
    
    let graph1Summed = graph1Grouped.map { day, group -> graph1Summary in
        let total = group.reduce(0.0) { $0 + $1.costCents }
        let date = formatter.date(from: day) ?? Date()
        return graph1Summary(day: date, costCents: total)
    }
    
    let graph1Data = graph1Summed.sorted { $0.day < $1.day }
    return graph1Data//.suffix(7)
}

let graph1Data = makeGraph1Data()

//MARK: Graph1 View
public struct Graph1: View {
    public init() {}
    let graph1Dates = graph1Data.map { $0.day }
    public var body: some View {
        VStack {
            Text("Total Cost-Time Graph (2026)")
                .font(.headline)
                .padding()
            Chart(graph1Data) { item in
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Cost in Cents", item.costCents)
                ).foregroundStyle(by: .value("Type", "Total Cost"))
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
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 10))
            }
            .frame(width: 350, height: 200)
            .chartLegend(position: .top)
        }
    }
}
//MARK: Database1
public struct DataTable1: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("Total Cost-Time Table").font(.headline)
            Table(graph1Data) {
                TableColumn("Id") { item in Text("\(item.id)")}
                TableColumn("Day") { item in
                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                }
                TableColumn("Cost (Cents)") { item in
                    Text(String(format: "%.2f", item.costCents))
                }
            }
            .frame(width: 300, height: 200)
        }
    }
}

