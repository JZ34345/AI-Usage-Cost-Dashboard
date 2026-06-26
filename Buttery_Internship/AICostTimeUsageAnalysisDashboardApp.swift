//
//  Buttery_InternshipApp.swift
//
//  Created by Jason Zhang on 6/15/26.
//

import SwiftUI
import SwiftData

@main
struct AICostTimeUsageAnalysisDashboardApp: App {

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var appData: AppData
    @State private var graphData: GraphDataSource
    
    init() {
        let source = GraphDataSource()
        _appData = State(initialValue: AppData(source: source))
        _graphData = State(initialValue: source)
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environment(appData).environment(graphData)
        }
        .modelContainer(sharedModelContainer)
    }
}
