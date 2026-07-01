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
    @Query private var items: [Item]

    var body: some View {
        //TODO: Improve loading time and speed. Add a loading indicator of somesorts if it exceeds some sort of time (DONE)
        //TODO: Add a provider in graphData to handle file data usage. Add in flexibility to file lookup (DONE)
        //TODO: Start with some basic testing structure.
        //TODO: Improve on finer design details such as titles and labels (Done, Check again)
        
        
        //Overview page and graph types demostration
        if appData.viewSwitcher == .overview {
            Overview()
        //Secondary view, aggregation filter and data patterns/anamolies
        } else if appData.viewSwitcher == .aggregation {
            Aggregation()
        //Secondary view: focuses on drilldown filtering
        } else if appData.viewSwitcher == .drillDown {
            DrillDown()
        //Optional Graph Showcase. May be removed depending on relavance
        } else if appData.viewSwitcher == .graphShowcase {
            GraphShowcase()
        //Default screen will turn to Overview
        } else {
            Overview()
        }
        
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
