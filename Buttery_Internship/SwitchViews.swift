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

//Button created that allows switching between overview, aggregation, drilldown, and graph showcase views
struct ViewButton: View {
    @Environment(AppData.self) private var appData
    
    enum ViewSwitcher: String, CaseIterable {
        case overview = "Overview"
        case aggregation = "Aggregation"
        case drillDown = "DrillDown"
        case graphShowcase = "Graph Showcase"
    }
    
    //View switch UI structure
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
