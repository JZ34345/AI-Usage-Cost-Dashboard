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
    @Environment(AppData.self) private var appData
    
    //Links cluster enum to the string name of cluster in sample data
    var clusterId: String? {
        switch appData.drillFilterCluster {
        case .inital: return nil
        case .usWest: return appData.source.clusters.first {$0.region == "us-west-1"}?.id
        case .usEast: return appData.source.clusters.first {$0.region == "us-east-1"}?.id
        case .europeWest: return appData.source.clusters.first {$0.region == "eu-west-1"}?.id
        }
    }
    
    //Links node enum to the string name of each node in sample data
    var nodeId: String? {
        if case .node(let id, name: _) = appData.drillFilterNode { return id }
        return nil
    }
    
    //MARK: DrillDown data
    //Create the drilldown data based on the selected cluster and nodes
    var drilldownData: [GenericSummary] {
        let dates = appData.dateRangeFilter(option: appData.dateFilter,
                                            start: appData.startDate,
                                            end: appData.endDate)
        
        //Filter by specific cluster and node in that cluster
        if let clusterId = clusterId, let nodeId = nodeId {
            return makeGenericGraph(record: appData.source.records,
                                    filter: {records in dates(records) &&
                                             records.clusterId == clusterId &&
                                             records.nodeId == nodeId},
                                    groupBy: { records in records.queryType },
                                    metric: { $0.costCents },
                                    dayLimit: appData.dateByClosure(for: appData.dateFilter)
            )
        }
        //Filter by specific cluster
        else if let clusterId = clusterId {
            let nodeLookUp = Dictionary(uniqueKeysWithValues: appData.source.nodes.map {($0.id, $0.name)})
            return makeGenericGraph(record: appData.source.records,
                                    filter: {records in dates(records) && records.clusterId == clusterId},
                                    groupBy: {records in nodeLookUp[records.nodeId] ?? "Unknown"},
                                    metric: {$0.costCents},
                                    dayLimit: appData.dateByClosure(for: appData.dateFilter))
        }
        //No filter, groupby aggregation on clusters
        else {
            let clusterLookUp = Dictionary(uniqueKeysWithValues: appData.source.clusters.map { ($0.id, $0.name) })
            return makeGenericGraph(record: appData.source.records,
                                    filter: {records in dates(records)},
                                    groupBy: { record in clusterLookUp[record.clusterId] ?? "Unknown" },
                                    metric: { $0.costCents },
                                    dayLimit: appData.dateByClosure(for: appData.dateFilter)
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
                    DrillDownButton()
                        .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
                    DrillNodeButton()
                                        
                    DateFilterButton()
                }.padding()
                //MARK: View data structure
                //Graph and DataTable of a specific cluster and node in cluster
                if clusterId != nil && nodeId != nil {
                    HStack {
                        genericGraph(data: drilldownData,
                                     title: "Node \(appData.drillFilterNode.label) Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: drilldownData,
                                         title: "Node \(appData.drillFilterNode.label) DataTable",
                                         category: "Query Type",
                                         isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                //Graph and DataTable of a specific cluster
                else if clusterId != nil {
                    HStack {
                        genericGraph(data: drilldownData,
                                     title: "\(appData.drillFilterCluster.rawValue) Cluster Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: drilldownData,
                                         title: "\(appData.drillFilterCluster.rawValue) Cluster DataTable",
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
