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
            KPICard(title: "Days Abpve Average", value: nil, label: "\(overviewData.daysAboveAverage) days")
            HStack {
                KPICard(title: "Trend of Total Cost ", value: overviewData.costTrend / 100)
                InfoButton(description: "A calculation of the date range second half average cost subtracting the calculation of the date range first half average cost.")
            }
        }
    }
}
