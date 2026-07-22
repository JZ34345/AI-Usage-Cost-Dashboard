//
//  ContentView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/15/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //MARK: Look up button layout for charts and chart placement online for final polishing (google and pintrest different products).
        //MARK: Add graph summaries for the graph and make graph placement side-to-side with light borders
        //MARK: Switch the y-axis from cents to dollars for cost (Done)
    //Datatables done (check over for details)
    @Environment(\.modelContext) private var modelContext
    @Environment(AppData.self) private var appData

    var body: some View {
        HStack {
            Spacer()
            //Tabview for easy view switching
            TabView {
                Tab("Overview", systemImage: "chart.line.uptrend.xyaxis") {
                    //Overview page and graph types demostration
                    Overview()
                }
                Tab("Aggregation", systemImage: "slider.horizontal.3") {
                    //Secondary view, aggregation filter and data patterns/anamolies
                    Aggregation()
                }
                Tab("Drilldown", systemImage: "arrow.down.right.circle") {
                    //Secondary view: focuses on drilldown filtering
                    DrillDown()
                }
                Tab("WoW", systemImage: "star") {
                    //Secondary View: Week-Over-Week Delta calculation
                    WoW()
                }
                Tab("Forecast", systemImage: "gear") {
                    //Secondary View: Linear Regression forecast for next 30 days
                    Forecast()
                }
            }.tabViewStyle(.automatic)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        CSVExport()
                    }
                }
            
            Spacer()
        }
    }
}
