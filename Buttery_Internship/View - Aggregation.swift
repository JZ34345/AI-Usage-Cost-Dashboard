//
//  SecondaryView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/19/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData


 struct Aggregation: View {
     @Environment(AppData.self) private var appData
    
    //MARK: Variables and data structures
    var isDelta: Bool {
        appData.mainFilter == .wow
    }
    //total cents graph data
    var graphData: [GenericSummary] {
        if appData.mainFilter != .wow {
            return appData.categoryGraphData
        } else {
            return appData.categoryWoWGraphData
        }
    }
    //average cents graph data
    var averageGraphData: [GenericSummary] {
         if appData.mainFilter != .wow {
             return appData.averageTotalGraphData
         } else {
             return appData.averageWoWGraphData
         }
     }
    //Aggregation Secondary view
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    
                    //MARK: Export button
                    Spacer()
                    VStack {
                        Text("Total Data Export")
                        CSVExport(data: graphData)
                    }
                    VStack {
                        Text("Avg Data Export")
                        CSVExport(data: averageGraphData)
                    }

                }
                //MARK: View Button
                VStack {
                    Text("\(appData.mainFilter.rawValue) Aggregation View").font(.largeTitle)
                    ViewButton()
                }
                //MARK: Filter and datefilter buttons
                HStack {
                    FilterButton()
                    DateFilterButton()
                }.padding()
                
                //MARK: Graph Arrangement
                //Non delta option
                if isDelta == false {
                    //Total data on left, average data on right
                    HStack {
                        genericGraph(data: graphData,
                                     title: "\(appData.mainFilter.rawValue) Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericGraph(data: averageGraphData,
                                     title: "\(appData.mainFilter.rawValue) Average Cost-Time Graph (2026)",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                    }

                    Spacer(minLength: 100)

                    //Total data on left, average data on right
                    HStack {
                        genericDataTable(data: graphData,
                                         title: "\(appData.mainFilter.rawValue) Cost DataTable",
                                         category: appData.mainFilter.rawValue,
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: averageGraphData,
                                         title: "\(appData.mainFilter.rawValue) Average Cost DataTable",
                                         category: appData.mainFilter.rawValue,
                                         isDelta: false,
                                         isAverage: true)
                    }
                //Delta option
                } else {
                    //Total data on left, average data on right
                    HStack {
                        genericGraph(data: graphData,
                                     title: "\(appData.mainFilter.rawValue) Delta-Time Graph (2026)",
                                     ylabel: "Delta (Cents)",
                                     isDelta: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericGraph(data: averageGraphData,
                                     title: "\(appData.mainFilter.rawValue) Average Delta-Time Graph (2026)",
                                     ylabel: "Average Delta (Cents)",
                                     isDelta: true)
                        
                    }

                    Spacer(minLength: 100)

                    //Total data on left, average data on right
                    HStack {
                        genericDataTable(data: graphData,
                                         title: "\(appData.mainFilter.rawValue) Delta DataTable",
                                         category: appData.mainFilter.rawValue,
                                         isDelta: true,
                                         isAverage: false
                        )
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: averageGraphData,
                                         title: "\(appData.mainFilter.rawValue) Average Delta DataTable",
                                         category: appData.mainFilter.rawValue,
                                         isDelta: true,
                                         isAverage: false
                        )
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}


