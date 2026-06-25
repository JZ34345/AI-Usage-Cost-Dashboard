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
    
    //variables and data structures
    var isDelta: Bool {
        appData.mainFilter == .wow
    }
    
    var graphData: [GenericSummary] {
        if appData.mainFilter != .wow {
            return appData.totalGraphData
        } else {
            return appData.WoWGraphData
        }
        
    }
    //Main seocndary view
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: graphData)
                }
                Text("Test").font(.title)
                HStack {
                    FilterButton()
                    DateFilterButton()
                }.padding()
                if isDelta == false {
                    HStack {
                        genericGraph(data: graphData,
                                     title: "Test",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: graphData,
                                         title: "Test",
                                         category: appData.mainFilter.rawValue,
                                         isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                } else {
                    HStack {
                        genericGraph(data: graphData,
                                     title: "Test",
                                     ylabel: "Delta (Cents)",
                                     isDelta: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: graphData,
                                     title: "Test",
                                         category: appData.mainFilter.rawValue,
                                     isDelta: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}


