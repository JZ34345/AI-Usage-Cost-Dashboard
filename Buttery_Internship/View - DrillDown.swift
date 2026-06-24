//
//  DrillDownView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/22/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

public struct DrillDown: View {
    //MARK: Data objects
    @State var showDrillCluster: DrillDownButton.DrillDownClusterOptions = .inital
    @State var showDrillNode: DrillNodeButton.DrillDownNodeOptions = .inital
    @State var dateFilter: DateFilterButton.DataFilterOptions = .seven
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    //Links cluster enum to the string name of cluster in sample data
    var clusterId: String? {
        switch showDrillCluster {
        case .inital: return nil
        case .usWest: return sampleData.clusters.first {$0.region == "us-west-1"}?.id
        case .usEast: return sampleData.clusters.first {$0.region == "us-east-1"}?.id
        case .europeWest: return sampleData.clusters.first {$0.region == "eu-west-1"}?.id
        }
    }
    
    //Links node enum to the string name of each node in sample data
    var nodeId: String? {
        if case .node(let id, name: _) = showDrillNode { return id }
        return nil
    }
    
    //MARK: DrillDown data
    //Create the drilldown data based on the selected cluster and nodes
    var drilldownData: [GenericSummary] {
        let dates = dateRangeFilter(option: dateFilter, start: startDate, end: endDate)
        
        //Filter by specific cluster and node in that cluster
        if let clusterId = clusterId, let nodeId = nodeId {
            return makeGenericGraph(filter: {records in dates(records) &&
                                             records.clusterId == clusterId &&
                                             records.nodeId == nodeId},
                                    groupBy: { records in records.queryType },
                                    metric: { $0.costCents },
                                    dayLimit: dateByClosure(for: dateFilter)
            )
        }
        //Filter by specific cluster
        else if let clusterId = clusterId {
            let nodeLookUp = Dictionary(uniqueKeysWithValues: sampleData.nodes.map {($0.id, $0.name)})
            return makeGenericGraph(filter: {records in dates(records) && records.clusterId == clusterId},
                                    groupBy: {records in nodeLookUp[records.nodeId] ?? "Unknown"},
                                    metric: {$0.costCents}, dayLimit: dateByClosure(for: dateFilter))
        }
        //No filter, groupby aggregation on clusters
        else {
            let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.name) })
            return makeGenericGraph(filter: {records in dates(records)},
                                    groupBy: { record in clusterLookUp[record.clusterId] ?? "Unknown" },
                                    metric: { $0.costCents },
                                    dayLimit: dateByClosure(for: dateFilter)
            )
        }
    }
    
    public var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: drilldownData)
                    
                }
                Text("Test").font(.title)
                //MARK: Date and drilldown buttons
                HStack {
                    DrillDownButton(showDrillFilter: $showDrillCluster)
                        .onChange(of: showDrillCluster) {showDrillNode = .inital}
                    DrillNodeButton(showNodeFilter: $showDrillNode, clusterId: clusterId)
                                        
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                }.padding()
                //MARK: View data structure
                //Graph and DataTable of a specific cluster and node in cluster
                if clusterId != nil && nodeId != nil {
                    HStack {
                        genericGraph(data: drilldownData,
                                     title: "Node \(showDrillNode.label) Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: drilldownData,
                                         title: "Node \(showDrillNode.label) DataTable",
                                         category: "Query Type",
                                         isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                //Graph and DataTable of a specific cluster
                else if clusterId != nil {
                    HStack {
                        genericGraph(data: drilldownData,
                                     title: "\(showDrillCluster.rawValue) Cluster Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: drilldownData,
                                         title: "\(showDrillCluster.rawValue) Cluster DataTable",
                                         category: "Node",
                                         isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                //Graph and DataTable of cluster aggregation
                else {
                    HStack {
                        genericGraph(data: drilldownData,
                                     title: "Cluster Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: drilldownData,
                                         title: "Cluster DataTable",
                                         category: "Cluster",
                                         isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                Spacer()
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}
