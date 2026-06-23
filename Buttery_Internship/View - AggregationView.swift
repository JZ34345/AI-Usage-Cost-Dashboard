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
    @State var showSelectedFilter: FilterButton.FilterOptions = .total
    @State var dateFilter: DateFilterButton.DataFilterOptions = .seven
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    //variables and data structures
    var isDelta: Bool {
        showSelectedFilter == .wow
    }
    
    var graphData: [GenericSummary] {
        if showSelectedFilter != .wow {
            return makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                                    groupBy: groupByClosure(for: showSelectedFilter),
                                    metric: {$0.costCents},
                                    dayLimit: dateByClosure(for: dateFilter),
                                    applyDayLimit: dateFilter != .custom
            )
        } else {
            return makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                                    groupBy: groupByClosure(for: showSelectedFilter),
                                    metric: {$0.costCents},
                                    dayLimit: dateByClosure(for: dateFilter),
                                    applyDayLimit: dateFilter != .custom,
                                    groupWeek: true,
                                    delta: true,
            )
        }
        
    }
    //Main seocndary view
    public var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: graphData)
                    
                }
                Text("Test").font(.title)
                HStack {
                    FilterButton(showSelectFilter: $showSelectedFilter)
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
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
                                         category: showSelectedFilter.rawValue,
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
                                         category: showSelectedFilter.rawValue,
                                     isDelta: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}


