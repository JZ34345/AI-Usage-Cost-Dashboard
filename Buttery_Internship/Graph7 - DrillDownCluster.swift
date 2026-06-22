//
//  Cluster6 - DrillDown.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts

let nodeLookUp = Dictionary(uniqueKeysWithValues: sampleData.nodes.map { ($0.id, $0.name) })

let target = sampleData.clusters.first {$0.region == "us-west-1"}?.id

let westUSData = MakeGenericGraph(filter: {record in record.clusterId == target },
                                  groupBy: {nodeLookUp[$0.nodeId] ?? "Unknown"},
                                  metric: {$0.costCents},
                                  dayLimit: 30)

let westUSGraph = GenericGraph(data: westUSData,
                               title: "US West Nodes Cost-Time Graph",
                               ylabel: "Cost (Cents)",
                               isDelta: false)

let westUSDataTable = GenericDataTable(data: westUSData,
                                       title: "US West Nodes DataTable",
                                       category: "Node", isDelta: false)
