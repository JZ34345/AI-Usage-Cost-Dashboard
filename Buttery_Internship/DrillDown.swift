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
 struct DrillDownButton: View {
    @Binding private var showDrillFilter: DrillDownClusterOptions
    
     init(showDrillFilter: Binding<DrillDownClusterOptions>) {
        self._showDrillFilter = showDrillFilter
    }
    
     enum DrillDownClusterOptions: String, CaseIterable {
        case inital = "DrillDown: Clusters"
        case usWest = "US West"
        case usEast = "US East"
        case europeWest = "West Europe"
    }
    
     var body: some View {
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

 struct DrillNodeButton: View {
    @Binding private var showNodeFilter: DrillDownNodeOptions
    let clusterId: String?
    
     enum DrillDownNodeOptions: Hashable {
        case inital
        case node(id: String, name: String)
        
        var label: String {
            switch self {
            case .inital: return "DrillDown: Nodes"
            case .node(id: _, let name): return name
            }
        }
    }
    
     init(showNodeFilter: Binding<DrillDownNodeOptions>, clusterId: String?) {
            self._showNodeFilter = showNodeFilter
            self.clusterId = clusterId
        }
    
    var nodeOptions: [DrillDownNodeOptions] {
        guard let clusterId = clusterId else { return [.inital] }
        let nodes = sampleData.nodes.filter { $0.clusterId == clusterId }
        return [.inital] + nodes.map {.node(id: $0.id, name: $0.name)}
        
    }
    
     var body: some View {
        Menu {
            ForEach(nodeOptions, id: \.self) { option in
                Button(option.label) {
                    showNodeFilter = option
                }
                
            }
        } label: {
            Text(showNodeFilter.label)
        }.menuStyle(.borderedButton)
            .disabled(clusterId == nil)
    }
}
