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

let data3 = sampleData

// MARK: Graph 3 Structure
let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })

let clusterGraphData = MakeGenericGraph(groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                        metric: {$0.costCents}, dayLimit: 30 )

//MARK: Graph3 View
let clusterGraph = GenericGraph(data: clusterGraphData,
                                title: "Cluster Cost-Time Graph (2026)",
                                ylabel: "Cost (Cents)")
//MARK: Database 3
let clusterDataTable = GenericDataTable(data: clusterGraphData, title: "Cluster Cost-Time Table", category: "Cluster")


