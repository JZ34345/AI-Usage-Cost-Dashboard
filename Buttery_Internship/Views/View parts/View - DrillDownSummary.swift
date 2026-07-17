//
//  DrillDownSummaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct DrillDownSummaryView: View {
    @Environment(AppData.self) private var appData
    
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var drillDownData: DrillDownSummary {
        return makeDrillDownSummary(from: data)
    }
    
    var body: some View {
        if appData.drillFilterCluster == .inital {
            HStack {
                KPICard(title: "Total Spend", value: drillDownData.totalSpent / 100, format: "$%.2f")
                KPICard(title: "Top Cluster", value: nil, label: drillDownData.mostExpensiveNode)
                KPICard(title: "Top Cluster Cost", value: drillDownData.mostExpensiveNodeCost / 100, format: "$%.2f")
                KPICard(title: "Average per Cluster", value: drillDownData.averageCostPerNode / 100, format: "$%.2f")
                KPICard(title: "Dominant Cluster %", value: drillDownData.dominantCatagoryPct, format: "%.1f%")
                KPICard(title: "Cluster Count", value: nil, label: "\(drillDownData.nodeCount)")
            }
        } else if appData.drillFilterCluster != .inital {
            HStack {
                KPICard(title: "Total Spend", value: drillDownData.totalSpent / 100, format: "$%.2f")
                KPICard(title: "Top Node", value: nil, label: drillDownData.mostExpensiveNode)
                KPICard(title: "Top Node Cost", value: drillDownData.mostExpensiveNodeCost / 100, format: "$%.2f")
                KPICard(title: "Average per Node", value: drillDownData.averageCostPerNode / 100, format: "$%.2f")
                KPICard(title: "Dominant node %", value: drillDownData.dominantCatagoryPct, format: "%.1f%")
                KPICard(title: "Node Count", value: nil, label: "\(drillDownData.nodeCount)")
            }
        } else {
            HStack{
                KPICard(title: "Total Spend", value: drillDownData.totalSpent / 100, format: "$%.2f")
                KPICard(title: "Top Query", value: nil, label: drillDownData.mostExpensiveNode)
                KPICard(title: "Top Query Cost", value: drillDownData.mostExpensiveNodeCost / 100, format: "$%.2f")
                KPICard(title: "Average per Query", value: drillDownData.averageCostPerNode / 100, format: "$%.2f")
                KPICard(title: "Dominant Query %", value: drillDownData.dominantCatagoryPct, format: "%.1f%")
                KPICard(title: "Queries Count", value: nil, label: "\(drillDownData.nodeCount)")
            }
        }
    }
}
