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
    
    public var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer(minLength: 600)
                    //MARK: Export buttons
                    VStack {
                        Text("Total Data Export")
                        CSVExport(data: appData.drilldownData)
                    }
                    VStack {
                        Text("Average Data Export")
                        CSVExport(data: appData.drilldownAverageData)
                    }

                }
                //MARK: View switch button
                VStack {
                    Text("Drilldown View").font(.largeTitle)
                    ViewButton()
                }
                //MARK: Date and drilldown buttons
                HStack {
                    DrillDownButton()
                        .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
                    DrillNodeButton()
                                        
                    DateFilterButton()
                }.padding()
                
                //MARK: View graph arrangement
                //Graph and DataTable of a specific cluster and node in cluster
                //MARK: Specific cluster's node
                if appData.clusterId != nil && appData.nodeId != nil {
                    //Total data on left, average data on right
                    HStack {
                        genericGraph(data: appData.drilldownData,
                                     title: "Node \(appData.drillFilterNode.label) Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "Node \(appData.drillFilterNode.label) Cost-Time Average Graph",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Spacer(minLength: 100)

                    //Total data on left, average data on right
                    HStack {
                        genericDataTable(data: appData.drilldownData,
                                         title: "Node \(appData.drillFilterNode.label) Cost DataTable",
                                         category: "Query Type",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: appData.drilldownData,
                                         title: "Node \(appData.drillFilterNode.label) Average Cost DataTable",
                                         category: "Query Type",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                //MARK: Specific cluster
                //Graph and DataTable of a specific cluster
                else if appData.clusterId != nil {
                    //Total data on left, average data on right
                    HStack {
                        genericGraph(data: appData.drilldownData,
                                     title: "\(appData.drillFilterCluster.rawValue) Cluster Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "\(appData.drillFilterCluster.rawValue) Cluster Cost-Time Average Graph",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Spacer(minLength: 100)

                    //Total data on left, average data on right
                    HStack {
                        genericDataTable(data: appData.drilldownData,
                                         title: "\(appData.drillFilterCluster.rawValue) Cluster Cost DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: appData.drilldownAverageData,
                                         title: "\(appData.drillFilterCluster.rawValue) Cluster Average Cost DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                //MARK: All clusters
                //Graph and DataTable of cluster aggregation
                else {
                    //Total data on left, average data on right
                    HStack {
                        genericGraph(data: appData.drilldownData,
                                     title: "Cluster Cost-Time Graph",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "Cluster Cost-Time Graph",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }

                    Spacer(minLength: 100)

                    //Total data on left, average data on right
                    HStack {
                        genericDataTable(data: appData.drilldownData,
                                         title: "Cluster DataTable",
                                         category: "Cluster",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Divider()
                        genericDataTable(data: appData.drilldownAverageData,
                                         title: "Cluster Average Cost DataTable",
                                         category: "Cluster",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}
