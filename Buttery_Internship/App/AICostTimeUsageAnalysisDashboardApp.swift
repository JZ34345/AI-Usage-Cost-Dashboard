//
//  Buttery_InternshipApp.swift
//
//  Created by Jason Zhang on 6/15/26.
//

import SwiftUI
import SwiftData

@main
struct AICostTimeUsageAnalysisDashboardApp: App {
    //MARK: Data in use
    @State private var appData: AppData
    @State private var graphData: GraphDataSource
    
    init() {
        let source = GraphDataSource(provider: BundleFileProvider(fileName: "sample-data"))
        _appData = State(initialValue: AppData(source: source))
        _graphData = State(initialValue: source)
    }

    var body: some Scene {
        WindowGroup {
            //ContentView utilizes two observable enviornments: the source data enviornment (GraphData) and the modified data enviornment (AppData)
            ContentView().environment(appData).environment(graphData)
        }.defaultSize(width: 1200, height: 900)
            .windowResizability(.contentMinSize)
    }
}
