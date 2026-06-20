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

public let totalGraphData = MakeGenericGraph(metric: { $0.costCents}, dayLimit: 30)
public let totalGraph = GenericGraph(
    data: totalGraphData,
    title: "Total Cost-Time Graph (2026)",
    ylabel: "Cost (Cents)",
    isDelta: false
)
public let totalDataTable = GenericDataTable(data: totalGraphData,
                                             title: "Total Cost-Time Table",
                                             category: " ", isDelta: false)
