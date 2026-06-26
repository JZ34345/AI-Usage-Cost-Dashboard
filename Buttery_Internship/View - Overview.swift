import Cocoa
import Cocoa
import SwiftUI
import Charts
import SwiftData

 struct Overview: View {
     @Environment(AppData.self) private var appData
     
     var body: some View {
        @Bindable var appBindData = appData
         
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: appData.totalGraphData)
                    
                }
                Text("Overview").font(.title)
                HStack {
                    DateFilterButton()
                }.padding()
                HStack {
                    genericGraph(data: appData.totalGraphData,
                                 title: "Total Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: false)
                    .frame(maxWidth: .infinity)
                    Divider()
                    genericGraph(data: appData.WoWGraphData,
                                 title: "WoW Delta Cost-Time Graph",
                                 ylabel: "Cost (Cents)",
                                 isDelta: true)
                        .frame(maxWidth: .infinity)
                }
                
                Spacer(minLength: 100)
                
                HStack {
                    genericDataTable(data: appData.totalGraphData,
                                    title: "Total Cost DataTable",
                                    category: "Total",
                                    isDelta: false)
                   .frame(maxWidth: .infinity)
                    Divider()
                    genericDataTable(data: appData.WoWGraphData,
                                     title: "WoW Delta DataTable",
                                     category: "WoW",
                                     isDelta: true)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
}
