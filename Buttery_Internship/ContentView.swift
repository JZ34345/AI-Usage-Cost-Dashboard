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
    @Query private var items: [Item]

    var body: some View {
        //Overview page and graph types demostration
        //Overview()
        //Secondary view, filter and csv export showcase, and data patterns/anamolies
        //Test()
        DrillDown()
        //Future items: finish drilldown filter, add screen change from overview to secondary view, finish design elements (enhance graph/table size), and fix bugs/errors that pop up (delta cost column no name change)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
