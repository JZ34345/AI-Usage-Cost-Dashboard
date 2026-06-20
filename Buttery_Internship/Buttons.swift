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

//MARK: Drilldown in progress
public struct DrillDownButton: View {
    @State private var showFilter = "DrillDown: Clusters"
    public init() {}
    
    public let FilterOptions = ["US West", "US East", "West Europe"]
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
