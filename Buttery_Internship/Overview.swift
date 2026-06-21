import Cocoa
import Cocoa
import SwiftUI
import Charts
import SwiftData

public struct Overview: View {
    @State private var mainFilter = "None"
    @State private var dateFilter = "Date"
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    var totalGraphData: [GenericSummary] {
        MakeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         metric: { $0.costCents},
                         dayLimit: dateByClosure(for: dateFilter))
    }
    
    var WoWGraphData: [GenericSummary] {
        MakeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         groupBy: {_ in "WoW Delta"},
                         metric: { $0.costCents},
                         dayLimit: dateByClosure(for: dateFilter),
                         groupWeek: true,
                         delta: true
        )
    }
    
    public var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: totalGraphData)
                    
                }
                Text("Overview").font(.title)
                HStack {
                    FilterButton(showSelectFilter: $mainFilter)
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                    DrillDownButton()
                }.padding()
                HStack {
                    GenericGraph(data: totalGraphData,
                                 title: "Total Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: false)
                        .frame(maxWidth: .infinity)
                    Divider()
                    GenericDataTable(data: totalGraphData,
                                     title: "Total Cost DataTable",
                                     category: "Total",
                                     isDelta: false)
                    .frame(maxWidth: .infinity)
                    GenericGraph(data: WoWGraphData,
                                 title: "WoW Delta Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: true)
                        .frame(maxWidth: .infinity)
                    Divider()
                    GenericDataTable(data: WoWGraphData,
                                     title: "WoW Delta DataTable",
                                     category: "WoW",
                                     isDelta: true)
                    .frame(maxWidth: .infinity)
                }
                VStack {
                    Divider().background(Color.black)
                    Spacer(minLength: 80)
                }
                Text("Graphs Showcase").font(.title)
                VStack {
                    HStack {
                        clusterGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        clusterDataTable
                            .frame(maxWidth: .infinity)
                        modelGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        modelDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 80)
                    
                    HStack {
                        clustersGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        clustersDataTable
                            .frame(maxWidth: .infinity)
                        westUSGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        westUSDataTable
                            .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 80)
                    
                    HStack {
                        westUSQueryGraph
                            .frame(maxWidth: .infinity)
                        Divider()
                        westUSQueryDataTable
                            .frame(maxWidth: .infinity)
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
