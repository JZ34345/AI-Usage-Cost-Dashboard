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


public struct Test: View {
    @State var showSelectedFilter = "None"
    @State var dateFilter = "Date"
    var graphData: [GenericSummary] {
        MakeGenericGraph(groupBy: groupByClosure(for: showSelectedFilter),
                         metric: {$0.costCents},
                         dayLimit: dateByClosure(for: dateFilter))
    }
        
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport()
                    
                }
                Text("Test").font(.title)
                HStack {
                    FilterButton(showSelectFilter: $showSelectedFilter)
                    DateFilterButton(showDateFilter: $dateFilter)
                    DrillDownButton()
                }.padding()
                HStack {
                    GenericGraph(data: graphData,
                                 title: "Test",
                                 ylabel: "Cost")
                        .frame(maxWidth: .infinity)
                    GenericDataTable(data: graphData, title: "Test", category: showSelectedFilter)
                }
            }
        }
    }
    
}


