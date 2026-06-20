//
//  ModelGraph.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts

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

let modelLookUp = Dictionary(uniqueKeysWithValues: sampleData.models.map { ($0.id, $0.displayName) })


let modelGraphData = MakeGenericGraph(groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                      metric: {$0.costCents / Double($0.queryCount)}, dayLimit: 30)


//MARK: Graph4 View
let modelGraph = GenericGraph(data: modelGraphData,
                              title: "Model Cost-Time Graph (2026)",
                              ylabel: "Average Cost (Cents)",
                              isDelta: false)
//MARK: Database 4
let modelDataTable = GenericDataTable(data: modelGraphData,
                                      title: "Model Average Cost-Time Table",
                                      category: "ModelId",
                                      isDelta: false)
