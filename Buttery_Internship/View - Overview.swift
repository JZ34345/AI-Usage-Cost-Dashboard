import Cocoa
import Cocoa
import SwiftUI
import Charts
import SwiftData

 struct Overview: View {
    @State private var dateFilter: DateFilterButton.DataFilterOptions = .seven
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
                Text("Overview").font(.title)
                HStack {
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                }.padding()
                HStack {
                    genericGraph(data: totalGraphData,
                                 title: "Total Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: false)
                    .frame(maxWidth: .infinity)
                    Divider()
                    genericGraph(data: WoWGraphData,
                                 title: "WoW Delta Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: true)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer(minLength: 100)
                
                HStack {
                    
                    genericDataTable(data: totalGraphData,
                                    title: "Total Cost DataTable",
                                    category: "Total",
                                    isDelta: false)
                   .frame(maxWidth: .infinity)
                    Divider()
                    genericDataTable(data: WoWGraphData,
                                     title: "WoW Delta DataTable",
                                     category: "WoW",
                                     isDelta: true)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
}
