//
//  OverviewSummaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct OverviewSummaryView: View {
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var overviewData: OverviewSummary {
        return makeOverviewSummary(from: data)
    }
    
    var body: some View {
        HStack {
            KPICard(title: "Total Cost", value: overviewData.totalCost / 100, format: "$%.2f")
            KPICard(title: "Daily Average", value: overviewData.dailyAverage / 100, format: "$%.2f")
            KPICard(title: "Highest Day Cost", value: overviewData.highestDayCost / 100, format: "$%.2f")
            KPICard(title: "Cost Trend", value: overviewData.costTrend / 100)
            KPICard(title: "Days Abpve Average", value: nil, label: "\(overviewData.daysAboveAverage) days")
            
        }
    }
}
