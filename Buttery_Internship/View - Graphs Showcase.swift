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
import SwiftData

 struct GraphShowcase: View {
    @State private var mainFilter: FilterButton.FilterOptions = .total
    @State private var dateFilter: DateFilterButton.DataFilterOptions = .thirty
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    var totalGraphData: [GenericSummary] {
        makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         metric: { $0.costCents},
                         dayLimit: dateByClosure(for: dateFilter))
    }
    
    var WoWGraphData: [GenericSummary] {
        makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         groupBy: {_ in "WoW Delta"},
                         metric: { $0.costCents},
                         dayLimit: dateByClosure(for: dateFilter),
                         groupWeek: true,
                         delta: true
        )
    }
    
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: totalGraphData)
                    
                }
                Text("Graph Showcase").font(.title)
                HStack {
                    FilterButton(showSelectFilter: $mainFilter)
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                }.padding()
                VStack {
                    HStack {
                        clusterGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        clusterDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)

                    HStack {
                        clustersGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        clustersDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        modelGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        modelDataTable
                            .frame(maxWidth: .infinity)
                    }

                    Spacer(minLength: 150)

                    HStack {
                        modelsGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        modelsDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        westUSGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        westUSDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        westUSQueryGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        westUSQueryDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        errorGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        errorDataTable
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
}

