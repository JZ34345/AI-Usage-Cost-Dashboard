//
//  View - Graphs Showcase.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/23/26.
//
import Cocoa
import Cocoa
import SwiftUI
import Charts
//MARK: Graph Showcase
//Future: add some way to aggregate WoW by categories
struct WoW: View {
    @Environment(AppData.self) private var appData
    
    var filterWoWTitle: String {
        switch appData.multiSelectFilter.count {
        case 0: return "None"
        case 1: return appData.multiSelectFilter.first!.rawValue
        default: return appData.multiSelectFilter.map {$0.rawValue}.sorted().joined(separator: " + ")
        }
    }
    
    var body: some View {
        ScrollView([.vertical]) {
            if appData.costType == .total {
                WoWTitleAndButtonLayout(
                    title: "\(filterWoWTitle) WoW Delta Cost-Time Graph (2026)",
                    description: "(WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week)")
                
                //MARK: WoW Delta
                genericGraph(data: appData.WoWAggregateGraphData,
                             ylabel: "Delta (¢)",
                             isDelta: true)
                    .frame(maxWidth: .infinity)
                
                Spacer(minLength: 100)

                genericDataTable(data: appData.WoWAggregateGraphData,
                                 title: "WoW Delta DataTable",
                                 category: "\(filterWoWTitle) WoW ",
                                 isDelta: true,
                                 isAverage: false)
                .frame(maxWidth: .infinity)
            } else {
                WoWTitleAndButtonLayout(
                    title: "\(filterWoWTitle) WoW Delta Average Cost-Time Graph (2026)",
                    description: "(WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week)")
                
                //MARK: WoW Average Delta
                genericGraph(data: appData.WoWAggregateGraphAverageData,
                             ylabel: "Delta (¢)",
                             isDelta: true)
                    .frame(maxWidth: .infinity)
                
                Spacer(minLength: 100)

                genericDataTable(data: appData.WoWAggregateGraphAverageData,
                                 title: "WoW Average Delta DataTable",
                                 category: "\(filterWoWTitle) WoW",
                                 isDelta: true,
                                 isAverage: false)
                .frame(maxWidth: .infinity)
            }
            
            
            
        }
    }
}

