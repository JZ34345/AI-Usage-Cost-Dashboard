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
                    
                    VStack {
                        Text("Total Data Export")
                        CSVExport(data: appData.totalGraphData)
                    }
                    VStack {
                        Text("WoW Data Export")
                        CSVExport(data: appData.WoWGraphData)
                    }

                }
                VStack {
                    Text("Overview").font(.title)
                    ViewButton()
                }
                
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
                                    isDelta: false,
                                    isAverage: false)
                   .frame(maxWidth: .infinity)
                    Divider()
                    genericDataTable(data: appData.WoWGraphData,
                                     title: "WoW Delta DataTable",
                                     category: "WoW",
                                     isDelta: true,
                                     isAverage: false
                    )
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
}
