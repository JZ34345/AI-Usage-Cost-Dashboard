import Cocoa
import SwiftUI
import Charts
//MARK: Overview
 struct Overview: View {
     @Environment(AppData.self) private var appData
     
     var body: some View {
        @Bindable var appBindData = appData
         
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    //MARK: Export buttons
                    Spacer()
                    VStack {
                        Text("CSV Export")
                        if appData.dataType == .total {
                            CSVExport(data: appData.totalGraphData)
                        } else {
                            CSVExport(data: appData.WoWGraphData)
                        }
                    }
                }
                VStack {
                    Text("Overview").font(.largeTitle)
                    HStack {
                        DataTypeSwitch()
                        //MARK: View switch button
                        ViewButton()
                    }.padding(.top)
                    
                }
                
                HStack {
                    //MARK: Date filter button
                    DateFilterButton()
                }.padding()
                
                //MARK: Graph arrangement
                if appData.dataType == .total {
                    
                    //MARK: Total Cost
                    genericGraph(data: appData.totalGraphData,
                                 title: "Total Cost-Time Graph (2026)",
                                 ylabel: "Cost (Cents)",
                                 isDelta: false)
                    .frame(maxWidth: .infinity)
                    
                    Spacer(minLength: 100)
                    
                    genericDataTable(data: appData.totalGraphData,
                                    title: "Total Cost DataTable",
                                    category: "Total",
                                    isDelta: false,
                                    isAverage: false)
                   .frame(maxWidth: .infinity)
                    
                } else {
                    //MARK: WoW Delta
                    genericGraph(data: appData.WoWGraphData,
                                 title: "WoW Delta Cost-Time Graph (2026)",
                                 ylabel: "Cost (Cents)",
                                 isDelta: true)
                        .frame(maxWidth: .infinity)
                    
                    Spacer(minLength: 100)

                    genericDataTable(data: appData.WoWGraphData,
                                     title: "WoW Delta DataTable",
                                     category: "WoW",
                                     isDelta: true,
                                     isAverage: false)
                    .frame(maxWidth: .infinity)
                }
                
            }
        }
    }
    
}
