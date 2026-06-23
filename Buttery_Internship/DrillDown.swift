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
    @Binding private var showDrillFilter: DrillDownClusterOptions
    
    public init(showDrillFilter: Binding<DrillDownClusterOptions>) {
        self._showDrillFilter = showDrillFilter
    }
    
    public enum DrillDownClusterOptions: String, CaseIterable {
        case inital = "DrillDown: Clusters"
        case usWest = "US West"
        case usEast = "US East"
        case europeWest = "West Europe"
    }
    
    public var body: some View {
        Menu {
            ForEach(DrillDownClusterOptions.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    showDrillFilter = option
                }
                
            }
        } label: {
            Text(showDrillFilter.rawValue)
        }.menuStyle(.borderedButton)
    }
}
