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
            //MARK: WoW Delta
            if appData.costType == .total {
                //Graph
                if appData.viewType == .graph {
                    WoWTitleAndButtonLayout(
                        title: "\(filterWoWTitle) WoW Delta Cost-Time Graph (2026)",
                        description: "WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week.").padding(.top)
                    
                    genericGraph(data: appData.WoWAggregateGraphData, ylabel: "Delta (¢)", isDelta: true)
                        .frame(maxWidth: .infinity)
                //Table
                } else {
                    WoWTitleAndButtonLayout(
                        title: "WoW Delta Table (2026)",
                        description: "This table displays all the data used for the graph. The specific data is change in AI usage cost week per week for one or more categories. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                    
                    genericDataTable(data: appData.WoWAggregateGraphData, category: "\(filterWoWTitle) WoW ",
                                     isDelta: true, isAverage: false)
                    .frame(maxWidth: .infinity)
                }
                
            //MARK: WoW Average Delta
            } else {
                //Graph
                if appData.viewType == .graph {
                    WoWTitleAndButtonLayout(
                        title: "\(filterWoWTitle) WoW Delta Average Cost-Time Graph (2026)",
                        description: "WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week.")
                    
                    genericGraph(data: appData.WoWAggregateGraphAverageData, ylabel: "Delta (¢)", isDelta: true)
                        .frame(maxWidth: .infinity)
                //Table
                } else {
                    WoWTitleAndButtonLayout(
                        title: "WoW Average Delta Table (2026)",
                        description: "This table displays all the data used for the graph. The specific data is change in average AI usage cost week per week for one or more categories. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                    
                    genericDataTable(data: appData.WoWAggregateGraphAverageData, category: "\(filterWoWTitle) WoW",
                                     isDelta: true, isAverage: false)
                    .frame(maxWidth: .infinity)
                }
                
            }
            
            
            
        }
    }
}

