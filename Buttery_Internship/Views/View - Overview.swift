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
                //MARK: Graph arrangement
                if appData.dataType == .total {
                    OverviewTitleAndButtonLayout(title: "Total Cost-Time Graph (2026)")
                    
                    //MARK: Total Cost
                    genericGraph(data: appData.totalGraphData,
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
                    WoWOverviewTitleAndButtonLayout(
                        title: "WoW Delta Cost-Time Graph (2026)",
                        description: "(WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week)")
                    
                    //MARK: WoW Delta
                    genericGraph(data: appData.WoWGraphData,
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
