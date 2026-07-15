//
//  DrillDownSummaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct DrillDownSummaryView: View {
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var drillDownData: DrillDownSummary {
        return makeDrillDownSummary(from: data)
    }
    
    var body: some View {
        HStack {
            KPICard(title: "Total Spend", value: drillDownData.totalSpent / 100, format: "$%.2f")
            KPICard(title: "Node Count", value: nil, label: "\(drillDownData.nodeCount)")
            KPICard(title: "Top Node", value: nil, label: drillDownData.mostExpensiveNode)
            KPICard(title: "Top Node Cost", value: drillDownData.mostExpensiveNodeCost / 100, format: "$%.2f")
            KPICard(title: "Average per Node", value: drillDownData.averageCostPerNode / 100, format: "$%.2f")
            KPICard(title: "Dominant Category %", value: drillDownData.dominantCatagoryPct, format: "%.1f%")

        }
    }
}
