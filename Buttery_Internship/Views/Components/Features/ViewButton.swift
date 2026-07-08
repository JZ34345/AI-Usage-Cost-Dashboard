//
//  SwitchViews.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/26/26.
//
import Cocoa
import SwiftUI
import Charts
//MARK: View Button
//Button created that allows switching between overview, aggregation, drilldown, and graph showcase views
struct ViewButton: View {
    @Environment(AppData.self) private var appData
    
        //MARK: Options
    enum ViewSwitcher: String, CaseIterable {
        case overview = "Overview"
        case aggregation = "Aggregation"
        case drillDown = "DrillDown"
        case graphShowcase = "Graph Showcase"
    }
        //MARK: UI Structure
    var body: some View {
        VStack {
            Text("View Type")
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
}
