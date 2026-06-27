//
//  SwitchViews.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/26/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

struct ViewButton: View {
    @Environment(AppData.self) private var appData
    
    enum ViewSwitcher: String, CaseIterable {
        case overview = "Overview"
        case aggregation = "Aggregation"
        case drilldown = "DrillDown"
        case graphShowcase = "Graph Showcase"
    }
    
    var body: some View {
        Menu {
            ForEach(ViewSwitcher.allCases, id: \.self) {option in
                Button(option.rawValue) {
                    appData.viewSwitcher = option
                }
            }
        } label: {
            Text(appData.viewSwitcher.rawValue)
        }.menuStyle(.button)
    }
}
