import Cocoa
import SwiftUI
import Charts
//MARK: Overview
 struct Overview: View {
     @Environment(AppData.self) private var appData
     
     var body: some View {
        @Bindable var appBindData = appData
         
        ScrollView() {
            VStack {
                //MARK: Total Cost
                if appData.dataType == .total {
                    //Graph
                    if appData.viewType == .graph {
                        OverviewTitleAndButtonLayout(title: "Total Cost-Time Graph", description: nil)
                            .padding(.top)
                        
                        OverviewSummaryView(data: appData.totalGraphData)
                                           
                        genericGraph(data: appData.totalGraphData, ylabel: "Cost ($)", isDelta: false)
                            .frame(maxWidth: .infinity)
                    //Table
                    } else {
                        OverviewTitleAndButtonLayout(
                            title: "Total Cost Table",
                            description: "This table displays all the data used for the graph. The specific data is the total cost of AI usage. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).")
                        .padding(.top)
                        
                        genericDataTable(data: appData.totalGraphData, category: "Total", isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity)
                    }
                //MARK: WoW Delta
                } else {
                    //Graph
                    if appData.viewType == .graph {
                        WoWOverviewTitleAndButtonLayout(
                            title: "WoW Delta Cost-Time Graph",
                            description: "WoW Delta refers to the cost difference, in cents, an AI uses in one week compared to the previous week.")
                        .padding(.top)
                        
                        WoWSummaryView(data: appData.WoWGraphData)
                        
                        genericGraph(data: appData.WoWGraphData,ylabel: "Delta ($)", isDelta: true)
                        .frame(maxWidth: .infinity)
                    } else {
                        //Table
                        WoWOverviewTitleAndButtonLayout(
                            title: "WoW Delta Table",
                            description: "This table displays all the data used for the graph. The specific data is change in AI usage cost week per week. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).")
                        .padding(.top)
                        
                        genericDataTable(data: appData.WoWGraphData, category: "WoW", isDelta: true, isAverage: false)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }.frame(maxWidth:.infinity, maxHeight: .infinity)
    }
    
}
