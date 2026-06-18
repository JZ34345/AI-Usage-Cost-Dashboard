//
//  Graph2.swift
//  
//
//  Created by Jason Zhang on 6/16/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

public let data2 = sampleData

//MARK: Graph2 Structure
public struct graph2Summary: Identifiable, Sendable {
    public let id = UUID()
    public let week: Date
    public let WoWCost: Double
    public let delta: Double
}

public func makeGraph2() -> [graph2Summary] {
    let formatter = ISO8601DateFormatter()
    let calendar = Calendar.current
    
    let graph2Grouped = Dictionary(grouping: data2.records) { record -> String in
        let graph2Date = formatter.date(from: record.day) ?? Date()
        let graph2Week = calendar.component(.weekOfYear, from: graph2Date)
        let graph2Year = calendar.component(.year, from: graph2Date)
        return "\(graph2Year)-W\(String(format: "%02d", graph2Week))"
    }
    let graph2Summed = graph2Grouped.map { week, group in
        let firstDate = formatter.date(from: group[0].day) ?? Date()
        return (week: week, firstDate: firstDate, WoWCost: group.reduce(0.0) {$0 + $1.costCents})
    }.sorted{$0.week < $1.week}
    
    var result: [graph2Summary] = []
    
    for (index, item) in graph2Summed.enumerated() {
        if index > 0 {
            result.append(graph2Summary(week: item.firstDate, WoWCost: item.WoWCost, delta: item.WoWCost - graph2Summed[index-1].WoWCost))
        } else {
            result.append(graph2Summary(week: item.firstDate, WoWCost: item.WoWCost, delta: 0))
        }
    }
    return result
}

let graph2Data = makeGraph2()//.suffix(30)

//MARK: Graph2 View
public struct Graph2: View {
    public init() {}
    let graph2Dates = graph2Data.map { $0.week }
    public var body: some View {
        VStack {
            Text("WoW Delta Cost-Time Graph")
                .font(.headline)
                .padding()
            Chart(graph2Data) { item in
                LineMark(
                    x: .value("Week", item.week),
                    y: .value("Cost in Cents", item.WoWCost)
                ).foregroundStyle(by: .value("Type", "WoW Cost"))
                LineMark(
                    x: .value("Week", item.week),
                    y: .value("Delta Cost", item.delta)
                ).foregroundStyle(by: .value("Type", "Delta"))
            }
            .chartXAxisLabel("Date", alignment: .center)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 5)) { value in
                    AxisGridLine()
                    AxisTick()
                    if let date = value.as(Date.self) {
                        AxisValueLabel(anchor: .top) {
                            Text(date, format: .dateTime.month(.abbreviated).day())
                                .font(.caption)
                            
                        }
                    }
                }
            }
            .chartYAxisLabel("WoW Delta Cost (Cents)", position: .trailing)
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 10))
            }
            .frame(width: 350, height: 200)
            .chartLegend(position: .top)
        }
    }
}

//MARK: DataTable2
public struct DataTable2: View {
    public init() {}
    public var body: some View {
        VStack {
            Text("Total Cost-Time Table").font(.headline)
            Table(graph2Data) {
                TableColumn("Id") { item in Text("\(item.id)")}
                TableColumn("Week") { item in
                    Text(item.week, format: .dateTime.month(.abbreviated).day().year())
                }
                TableColumn("WoWCost") { item in
                    Text(String(format: "%.2f", item.WoWCost))
                }
                TableColumn("Delta") { item in
                    Text(String(format: "%.2f", item.delta))
                }
            }
            .frame(width: 300, height: 200)
        }
    }
}
