//
//  Graph3.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts

let data3 = sampleData

// MARK: Graph 3 Structure
let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })

let clusterGraphData = makeGenericGraph(groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                        metric: {$0.costCents / Double($0.queryCount)}, dayLimit: 30 )

//MARK: Graph3 View
let clusterGraph = genericGraph(data: clusterGraphData,
                                title: "Cluster Average Cost-Time Graph (2026)",
                                ylabel: "Cost (Cents)",
                                isDelta: false
)
//MARK: Database 3
let clusterDataTable = genericDataTable(data: clusterGraphData,
                                        title: "Cluster Average Cost-Time Table",
                                        category: "Cluster",
                                        isDelta: false)


