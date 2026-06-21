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
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    var isDelta: Bool {
            showSelectedFilter == "WoW"
    }
    
    var graphData: [GenericSummary] {
        if showSelectedFilter != "WoW" {
            return MakeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                                    groupBy: groupByClosure(for: showSelectedFilter),
                                    metric: {$0.costCents},
                                    dayLimit: dateByClosure(for: dateFilter),
                                    applyDayLimit: dateFilter != "Custom"
            )
        } else {
            return MakeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                                    groupBy: groupByClosure(for: showSelectedFilter),
                                    metric: {$0.costCents},
                                    dayLimit: dateByClosure(for: dateFilter),
                                    applyDayLimit: dateFilter != "Custom",
                                    groupWeek: true,
                                    delta: true,
            )
        }
        
    }
        
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: graphData)
                    
                }
                Text("Test").font(.title)
                HStack {
                    FilterButton(showSelectFilter: $showSelectedFilter)
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                    DrillDownButton()
                }.padding()
                if !isDelta {
                    HStack {
                        GenericGraph(data: graphData,
                                     title: "Test",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                            .frame(maxWidth: .infinity)
                        GenericDataTable(data: graphData,
                                         title: "Test",
                                         category: showSelectedFilter,
                                         isDelta: false)
                    }
                } else {
                    HStack {
                        GenericGraph(data: graphData,
                                     title: "Test",
                                     ylabel: "Delta (Cents)",
                                     isDelta: true)
                            .frame(maxWidth: .infinity)
                        GenericDataTable(data: graphData,
                                         title: "Test",
                                         category: showSelectedFilter,
                                         isDelta: true)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
}


