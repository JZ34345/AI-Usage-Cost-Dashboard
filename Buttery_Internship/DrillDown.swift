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

//MARK: Drilldown for cluster button
 struct DrillDownButton: View {
     @Environment(AppData.self) private var appData
    
     enum DrillDownClusterOptions: String, CaseIterable {
        case inital = "DrillDown: Clusters"
        case usWest = "US West"
        case usEast = "US East"
        case europeWest = "West Europe"
    }
    
     //Main appearance of drilldown button
     var body: some View {
        Menu {
            ForEach(DrillDownClusterOptions.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    appData.drillFilterCluster = option
                }
                
            }
        } label: {
            Text(appData.drillFilterCluster.rawValue)
        }.menuStyle(.borderedButton)
    }
}

//MARK: Drilldown for specific node of a cluster
 struct DrillNodeButton: View {
    @Environment(AppData.self) private var appData
    
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
    
     //Selects specific node by choosing specific cluster first, filtering in process, and returning all records that match specific cluster and node
    var nodeOptions: [DrillDownNodeOptions] {
        guard let clusterId = appData.clusterId else { return [.inital] }
        let nodes = appData.source.nodes.filter { $0.clusterId == clusterId }
        return [.inital] + nodes.map {.node(id: $0.id, name: $0.name)}
        
    }
    
     //Drilldown node button UI structure
     var body: some View {
        Menu {
            ForEach(nodeOptions, id: \.self) { option in
                Button(option.label) {
                    appData.drillFilterNode = option
                }
                
            }
        } label: {
            Text(appData.drillFilterNode.label)
        }.menuStyle(.borderedButton)
             .disabled(appData.clusterId == nil)
    }
}
