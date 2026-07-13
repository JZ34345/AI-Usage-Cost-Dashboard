//
//  ContentView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/15/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(AppData.self) private var appData

    var body: some View {
        HStack {
            Spacer()
            //Fix design issues based on email. 
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
