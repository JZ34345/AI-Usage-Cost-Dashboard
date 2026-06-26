//
//  Graph3.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts

// MARK: Graph 3 Structure



//MARK: Graph3 View
genericGraph(data: clusterGraphData,
            title: "Cluster Average Cost-Time Graph (2026)",
            ylabel: "Cost (Cents)",
            isDelta: false)
//MARK: Database 3
genericDataTable(data: clusterGraphData,
                title: "Cluster Average Cost-Time Table",
                category: "Cluster",
                isDelta: false)


