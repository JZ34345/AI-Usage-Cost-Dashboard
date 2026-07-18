//
//  WoWSummaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct WoWSummaryView: View {
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var WoWData: WoWSummary {
        return makeWoWSummary(from: data)
    }
    
    var body: some View {
        HStack {
            KPICard(title: "Average WoW Delta Change", value: WoWData.averageWeeklyDelta / 100, format: "$%.2f")
            KPICard(title: "Biggest Increase", value: WoWData.maxIncrease / 100, format: "$%.2f")
            KPICard(title: "Biggest Decrease", value: WoWData.maxDecrease / 100, format: "$%.2f")
            KPICard(title: "Weeks Up and Down",
                    value: nil,
                    label: "\(WoWData.weeksIncreasing) ↑ | \(WoWData.weeksDecreasing) ↓")
            
        }
    }
}
