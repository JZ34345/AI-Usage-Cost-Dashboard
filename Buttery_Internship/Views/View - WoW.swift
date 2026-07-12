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
    
    var body: some View {
        ScrollView([.vertical]) {
            HStack {
                //MARK: Export Buttons
                Spacer()
                //Export button
                VStack {
                    if appData.costType == .total {
                        CSVExport(data: appData.WoWGraphData)
                    } else {
                        CSVExport(data: appData.WoWGraphAverageData)
                    }
                }
            }
            
            if appData.costType == .total {
                WoWTitleAndButtonLayout(
                    title: "WoW Delta Cost-Time Graph (2026)",
                    description: "(WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week)")
                
                //MARK: WoW Delta
                genericGraph(data: appData.WoWGraphData,
                             ylabel: "Delta (¢)",
                             isDelta: true)
                    .frame(maxWidth: .infinity)
                
                Spacer(minLength: 100)

                genericDataTable(data: appData.WoWGraphData,
                                 title: "WoW Delta DataTable",
                                 category: "WoW",
                                 isDelta: true,
                                 isAverage: false)
                .frame(maxWidth: .infinity)
            } else {
                WoWTitleAndButtonLayout(
                    title: "WoW Delta Average Cost-Time Graph (2026)",
                    description: "(WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week)")
                
                //MARK: WoW Average Delta
                genericGraph(data: appData.WoWGraphAverageData,
                             ylabel: "Delta (¢)",
                             isDelta: true)
                    .frame(maxWidth: .infinity)
                
                Spacer(minLength: 100)

                genericDataTable(data: appData.WoWGraphAverageData,
                                 title: "WoW Average Delta DataTable",
                                 category: "WoW",
                                 isDelta: true,
                                 isAverage: false)
                .frame(maxWidth: .infinity)
            }
            
            
            
        }
    }
}

