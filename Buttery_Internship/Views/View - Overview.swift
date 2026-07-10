import Cocoa
import SwiftUI
import Charts
//MARK: Overview
 struct Overview: View {
     @Environment(AppData.self) private var appData
     
     var body: some View {
        @Bindable var appBindData = appData
         
        ScrollView([.vertical]) {
            VStack(spacing: 8) {
                HStack {
                    //MARK: Buttons
                    Spacer()
                    //Export button
                    VStack {
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
                        Spacer()
                        //Data type button
                        DataTypeSwitch()
                        
                        //Date filter button
                        DateFilterButton()
                        Spacer()
                    }.padding(.top)
                }.padding(.bottom)

                //MARK: Graph arrangement
                if appData.dataType == .total {
                    
                    //MARK: Total Cost
                    genericGraph(data: appData.totalGraphData,
                                 title: "Total Cost-Time Graph (2026)",
                                 ylabel: "Cost (¢)",
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
                                 ylabel: "Delta (¢)",
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
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
    }
    
}
