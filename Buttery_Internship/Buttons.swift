//
//  Buttons.swift
//  
//
//  Created by Jason Zhang on 6/17/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Filter in progress
public struct FilterButton: View {
    @State private var showFilter = "MultiSelect"
    public init() {}
    
    public let FilterOptions = ["Cluster", "Query Type", "Model"]
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showFilter = option
                }
                
            }
        } label: {
            Label(showFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
    }
}

//MARK: Date filter in progress
public struct DateFilterButton: View {
    @State private var showFilter = "Date"
    public init() {}
    
    public let FilterOptions = ["7 Days", "30 Days", "90 Days", "Custom"]
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showFilter = option
                }
                
            }
        } label: {
            Label(showFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
    }
}

//MARK: Drilldown in progress
public struct DrillDownButton: View {
    @State private var showFilter = "DrillDown: Clusters"
    public init() {}
    
    public let FilterOptions = ["US West", "US East", "Europe"]
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showFilter = option
                }
                
            }
        } label: {
            Label(showFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
    }
}

//MARK: CSV export in progress
public struct CSVExport: View {
    public init() {}
    public var body: some View {
        Button(action: {print("File exported!")}) {
            Text("Export File").padding()
        }
    }
    
}
