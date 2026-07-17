//
//  SecondaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/19/26.
//
import Cocoa
import SwiftUI
import Charts
//MARK: Aggregation
 struct Aggregation: View {
     @Environment(AppData.self) private var appData
    
    //MARK: Variables and data structures
    //total cents graph data
    var graphData: [GenericSummary] {
        if appData.costType == .total {
            return appData.multiSelectGraphData
        } else {
            return appData.multiSelectAverageGraphData
        }
    }
     
     var filterTitle: String {
         switch appData.multiSelectFilter.count {
         case 0: return "None"
         case 1: return appData.multiSelectFilter.first!.rawValue
         default: return appData.multiSelectFilter.map {$0.rawValue}.sorted().joined(separator: " + ")
         }
     }
    
    //Aggregation Secondary view
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                //MARK: Multi-Select
                if appData.costType == .total {
                    //Graph
                    if appData.viewType == .graph {
                        AggregationTitleAndButtonLayout(title: "\(filterTitle) ", graphType: "Cost-Time Graph", description: nil, isAverage: false).padding(.top)
                        
                        MultiSelectSummaryView(data: graphData)
                        
                        genericGraph(data: graphData, ylabel: "Cost ($)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //Table
                    } else {
                        AggregationTitleAndButtonLayout(
                            title: "\(filterTitle)", graphType: "Cost-Time Table",
                            description: "This table displays all the data used for the graph. The specific data is AI usage cost for one or more categories. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).",
                            isAverage: false)
                        .padding(.top)
                        
                        HStack {
                            genericDataTable(data: graphData, category: filterTitle, isDelta: false, isAverage: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    
                //MARK: Multi-Select Average
                } else {
                    //Graph
                    if appData.viewType == .graph {
                        AggregationTitleAndButtonLayout(
                            title: "\(filterTitle)", graphType: "Cost-Time Graph", description: nil,
                            isAverage: true)
                        .padding(.top)
                                           
                        MultiSelectSummaryView(data: graphData)
                        
                        genericGraph(data: graphData, ylabel: "Average Cost ($)", isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //Table
                    } else {
                        AggregationTitleAndButtonLayout(
                            title: "\(filterTitle)", graphType: "Cost-Time Table",
                            description: "This table displays all the data used for the graph above. The specific data is AI usage average cost for one or more categories. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).",
                            isAverage: true)
                        .padding(.top)
                        
                        genericDataTable(data: graphData, category: filterTitle, isDelta: false, isAverage: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


