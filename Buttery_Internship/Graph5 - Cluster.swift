//
//  Graph5 - Cluster.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts

// MARK: Graph 5 Structure
let clusterLookUp2 = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })

let clustersGraphData = MakeGenericGraph(groupBy: {clusterLookUp2[$0.clusterId] ?? "Unknown"},
                                        metric: {$0.costCents}, dayLimit: 30 )

//MARK: Graph5 View
let clustersGraph = GenericGraph(data: clustersGraphData,
                                title: "Cluster Cost-Time Graph (2026)",
                                ylabel: "Cost (Cents)",
                                isDelta: false
)
//MARK: Database 5
let clustersDataTable = GenericDataTable(data: clustersGraphData,
                                        title: "Cluster Cost-Time Table",
                                        category: "Cluster",
                                        isDelta: false)
