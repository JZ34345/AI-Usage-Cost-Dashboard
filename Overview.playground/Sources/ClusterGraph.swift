//
//  Graph3.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData
import PlaygroundSupport

let data3 = sampleData

// MARK: Graph 3 Structure
public struct graph3Summary: Identifiable, Sendable {
    public let id = UUID()
    public let day: Date
    public let cluster: String
    public let costCents: Double
}

public func makeGraph3Data() -> [graph3Summary] {
    let formatter = ISO8601DateFormatter()
    let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })
    
    struct groupKey: Hashable {
        let day: String
        let region: String
    }
    
    let graph3Grouped = Dictionary(grouping: data3.records) {record -> groupKey in
        let region = clusterLookUp[record.clusterId] ?? "Unknown"
        return groupKey(day: record.day, region: region)
    }

    let graph3Aggregated = graph3Grouped.map { key, group -> graph3Summary in
        let date = formatter.date(from: key.day) ?? Date()
        let total = group.reduce(0.0) {$0 + $1.costCents}
        return graph3Summary(day: date, cluster: key.region, costCents: total)
    }
    
    let graph3Data = graph3Aggregated.sorted { $0.day < $1.day }
    return graph3Data.suffix(30)
}

let graph3Data = makeGraph3Data()

//MARK: Graph3 View
public struct Graph3: View {
    public init() {}
    let graph3Dates = graph3Data.map { $0.day }
    public var body: some View {
        VStack {
            Text("Cluster Cost-Time Graph (2026)")
                .font(.headline)
                .padding()
            Chart(graph3Data) { item in
                LineMark(
                    x: .value("Day", item.day),
                    y: .value("Cost in Cents", item.costCents)
                ).foregroundStyle(by: .value("Cluster", item.cluster))
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
//MARK: Database 3
public struct DataTable3: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("Total Cost-Time Table").font(.headline)
            Table(graph3Data) {
                TableColumn("Id") { item in Text("\(item.id)")}
                TableColumn("Cluster") { item in Text("\(item.cluster)")}
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


