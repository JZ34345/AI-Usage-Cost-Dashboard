//
//  ModelGraph.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts

let modelLookUp = Dictionary(uniqueKeysWithValues: sampleData.models.map { ($0.id, $0.displayName) })


let modelGraphData = MakeGenericGraph(groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                      metric: {$0.costCents}, dayLimit: 30)


//MARK: Graph4 View
let modelGraph = GenericGraph(data: modelGraphData,
                              title: "Model Average Cost-Time Graph (2026)",
                              ylabel: "Average Cost (Cents)",
                              isDelta: false)
//MARK: Database 4
let modelDataTable = GenericDataTable(data: modelGraphData,
                                      title: "Model Average Cost-Time Table",
                                      category: "ModelId",
                                      isDelta: false)
