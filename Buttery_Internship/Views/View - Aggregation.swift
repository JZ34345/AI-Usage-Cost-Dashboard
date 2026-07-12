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
         default: return appData.multiSelectFilter.map {$0.rawValue}.sorted().joined(separator: "+ ")
         }
     }
    
    //Aggregation Secondary view
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    //MARK: Buttons
                    Spacer()
                    //Export Button
                    CSVExport(data: graphData)
                }
                //MARK: Graph Arrangement
                //Non delta option
                if appData.costType == .total {
                    AggregationTitleAndButtonLayout(title: "\(filterTitle) Cost-Time Graph (2026)")
                    
                    HStack {
                        genericGraph(data: graphData,
                                     ylabel: "Cost (¢)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Spacer(minLength: 100)
                    
                    HStack {
                        genericDataTable(data: graphData,
                                         title: "\(filterTitle) Cost DataTable",
                                         category: filterTitle,
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    //MARK: Average Graphs
                } else {
                    AggregationTitleAndButtonLayout(title: "\(filterTitle) Average Cost-Time Graph (2026)")
                    
                    genericGraph(data: graphData,
                                 ylabel: "Average Cost (¢)",
                                 isDelta: false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Spacer(minLength: 100)
                    
                    genericDataTable(data: graphData,
                                     title: "\(filterTitle) Average Cost DataTable",
                                     category: filterTitle,
                                     isDelta: false,
                                     isAverage: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


