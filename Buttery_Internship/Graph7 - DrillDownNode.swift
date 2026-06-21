//
//  Graph7 - DrillDownNode.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts

let target2 = sampleData.nodes.first {$0.name == "usw-medium-02"}?.id

let westUSQueryData = MakeGenericGraph(filter: {record in record.clusterId == target && record.nodeId == target2 },
                                       groupBy: {records in records.queryType},
                                  metric: {$0.costCents},
                                  dayLimit: 30)

let westUSQueryGraph = GenericGraph(data: westUSQueryData,
                               title: "US West Node Query Cost-Time Graph",
                               ylabel: "Cost (Cents)",
                               isDelta: false)

let westUSQueryDataTable = GenericDataTable(data: westUSQueryData,
                                       title: "US West Node Query DataTable",
                                       category: "Node", isDelta: false)

