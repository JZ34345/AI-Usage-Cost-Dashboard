//
//  MultiSelectSummaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct MultiSelectSummaryView: View {
    @Environment(AppData.self) private var appData
    
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var multiSelectData: MultiSelectSummary {
        return makeMultiSelectSummary(from: data)
    }
    
    var body: some View {
        if appData.multiSelectFilter.count > 1{
            HStack {
                KPICard(title: "Top Category", value: nil, label: multiSelectData.topCategory)
                KPICard(title: "Top Category Cost", value: multiSelectData.topCategorySpent / 100, format: "$%.2f")
                KPICard(title: "Top Category %", value: multiSelectData.topCategoryPct, format: ("%.1f%%"))
                KPICard(title: "Lowest Category", value: nil, label: multiSelectData.lowestCategory)
                KPICard(title: "Most Volatile", value: nil, label: multiSelectData.mostVolatile)
                KPICard(title: "Categories", value: nil, label: "\(multiSelectData.categoryCount)")
            }
        } else {
            HStack {
                KPICard(title: "Top Category", value: nil, label: multiSelectData.topCategory)
                KPICard(title: "Top Category Cost", value: multiSelectData.topCategorySpent / 100, format: "$%.2f")
                KPICard(title: "Top Category %", value: multiSelectData.topCategoryPct, format: ("%.1f%%"))
                //KPICard(title: "Lowest Category", value: nil, label: multiSelectData.lowestCategory)
                KPICard(title: "Most Volatile", value: nil, label: multiSelectData.mostVolatile)
                //KPICard(title: "Categories", value: nil, label: "\(multiSelectData.categoryCount)")
            }
        }
    }
}
