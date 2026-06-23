//
//  Graph1.swift
//  
//
//  Created by Jason Zhang on 6/16/26.
//
//Old Code
import Cocoa
import SwiftUI
import Charts
import SwiftData

public let totalGraphData = makeGenericGraph(metric: { $0.costCents}, dayLimit: 30)
public let totalGraph = genericGraph(
    data: totalGraphData,
    title: "Total Cost-Time Graph (2026)",
    ylabel: "Cost (Cents)",
    isDelta: false
)
public let totalDataTable = genericDataTable(data: totalGraphData,
                                             title: "Total Cost-Time Table",
                                             category: " ", isDelta: false)
