//
//  View - Regression.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
import Cocoa
import SwiftUI
import Charts
//MARK: Overview
 struct Forecast: View {
     @Environment(AppData.self) private var appData
     
     var body: some View {
         @Bindable var appBindData = appData
         
         ScrollView() {
             VStack {
                 //MARK: Total Forecast
                 if appData.costType == .total {
                     //Graph
                     if appData.viewType == .graph {
                         RegressionTitleButtonLayout(title: "Total Cost", description: nil)
                             .padding(.top)
                         
                         RegressionSummaryView(data: appData.regressionTotalData)
                         
                         MLGraphs(realData: appData.totalGraphData, regressionData: appData.regressionTotalData, ylabel: "Cost ($)")
                             .frame(maxWidth: .infinity)
                         //Table
                     } else {
                         RegressionTitleButtonLayout(
                            title: "Total Cost",
                            description: "This table displays all the data used for the forecast. The specific data is the total cost prediction of AI usage for the next 30 days. Each row is an AI usage prediction containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).")
                         .padding(.top)
                         
                         genericDataTable(data: appData.regressionTotalData, category: "Total", isDelta: false,
                                          isAverage: false)
                         .frame(maxWidth: .infinity)
                     }
                     //MARK: Average Forecast
                 } else {
                     //Graph
                     if appData.viewType == .graph {
                         RegressionTitleButtonLayout(title: "Total Cost", description: nil)
                             .padding(.top)
                         
                         RegressionSummaryView(data: appData.regressionTotalAverageData)
                         
                         MLGraphs(realData: appData.totalGraphData, regressionData: appData.regressionTotalAverageData, ylabel: "Cost ($)")
                             .frame(maxWidth: .infinity)
                         //Table
                     } else {
                         RegressionTitleButtonLayout(
                            title: "Total Cost",
                            description: "This table displays all the data used for the forecast. The specific data is the total cost prediction of AI usage for the next 30 days. Each row is an AI usage prediction containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).")
                         .padding(.top)
                         
                         RegressionSummaryView(data: appData.regressionTotalAverageData)
                         
                         genericDataTable(data: appData.regressionTotalAverageData, category: "Total", isDelta: false,
                                          isAverage: false)
                         .frame(maxWidth: .infinity)
                     }
                 }
             }.frame(maxWidth:.infinity, maxHeight: .infinity)
         }
     }
}

