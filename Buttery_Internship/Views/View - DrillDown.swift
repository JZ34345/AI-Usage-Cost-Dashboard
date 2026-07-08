//
//  DrillDownView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/22/26.
//
import Cocoa
import SwiftUI
import Charts
//MARK: Drilldown
public struct DrillDown: View {
    @Environment(AppData.self) private var appData
    
    public var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    //MARK: Export buttons
                    Spacer()
                    VStack {
                        Text("Total Data Export")
                        if appData.costType == .total {
                            CSVExport(data: appData.drilldownData)
                        } else {
                            CSVExport(data: appData.drilldownAverageData)
                        }
                    }
                    

                }
                //MARK: View switch button
                VStack {
                    Text("Drilldown View").font(.largeTitle)
                    HStack() {
                        CostTypeSwitch()
                        ViewButton()
                    }.padding(.top)
                }
                //MARK: Date and drilldown buttons
                HStack {
                    DrillDownButton()
                        .onChange(of: appData.drillFilterCluster) {appData.drillFilterNode = .inital}
                    DrillNodeButton()
                                        
                    DateFilterButton()
                }.padding()
                //MARK: Total Cost
                //Graph and DataTable of a specific cluster and node in cluster
                if appData.costType == .total {
                    
                            //MARK: Specific cluster's node
                    if appData.clusterId != nil && appData.nodeId != nil {
                        //Total data on left, average data on right
                        genericGraph(data: appData.drilldownData,
                                     title: "Node \(appData.drillFilterNode.label) Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownData,
                                         title: "Node \(appData.drillFilterNode.label) Cost DataTable",
                                         category: "Query Type",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                            //MARK: Specific cluster
                    //Graph and DataTable of a specific cluster
                    else if appData.clusterId != nil {
                        genericGraph(data: appData.drilldownData,
                                     title: "\(appData.drillFilterCluster.rawValue) Cluster Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownData,
                                         title: "\(appData.drillFilterCluster.rawValue) Cluster Cost DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                            //MARK: All clusters
                    //Graph and DataTable of cluster aggregation
                    else {
                        //Total data on left, average data on right
                        genericGraph(data: appData.drilldownData,
                                     title: "Cluster Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownData,
                                         title: "Cluster Cost DataTable",
                                         category: "Cluster",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                //MARK: Average Cost
                } else {
                        
                        
                        //MARK: Specific cluster's node
                    if appData.clusterId != nil && appData.nodeId != nil {
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "Node \(appData.drillFilterNode.label) Average Cost-Time Graph (2026)",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownAverageData,
                                         title: "Node \(appData.drillFilterNode.label) Average Cost DataTable",
                                         category: "Query Type",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //MARK: Specific cluster
                    } else if appData.clusterId != nil {
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "\(appData.drillFilterCluster.rawValue) Cluster Average Cost-Time Graph (2026)",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownAverageData,
                                         title: "\(appData.drillFilterCluster.rawValue) Cluster Average Cost DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //MARK: All clusters
                    } else {
                        genericGraph(data: appData.drilldownAverageData,
                                     title: "Cluster Average Cost-Time Graph (2026)",
                                     ylabel: "Average Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Spacer(minLength: 100)
                        
                        genericDataTable(data: appData.drilldownAverageData,
                                         title: "Cluster Average Cost DataTable",
                                         category: "Cluster",
                                         isDelta: false,
                                         isAverage: true)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }.frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}
