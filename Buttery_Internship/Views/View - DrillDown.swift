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
                //MARK: Total Cost
                if appData.costType == .total {
                    //MARK: Specific cluster's node
                    //Graph and DataTable of a specific cluster and node in cluster
                    if appData.clusterId != nil && appData.nodeId != nil {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(
                                title: "Node \(appData.drillFilterNode.label) Cost-Time Graph (2026)", description: nil)
                            .padding(.top)
                            
                            genericGraph(data: appData.drilldownData, ylabel: "Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(
                                title: "Node \(appData.drillFilterNode.label) Cost Table (2026)",
                                description: "This table displays all the data used for the graph. The specific data is the AI usage cost of a node in a specified cluster. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownData, category: "Query Type", isDelta: false, isAverage: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                                                
                        
                    }
                    //MARK: Specific cluster
                    //Graph and Table of a specific cluster
                    else if appData.clusterId != nil {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(
                                title: "Cluster \(appData.drillFilterCluster.rawValue) Cost-Time Graph (2026)", description: nil)
                            .padding(.top)
                            
                            genericGraph(data: appData.drilldownData, ylabel: "Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(
                                title: "Cluster \(appData.drillFilterCluster.rawValue) Cost Table (2026)",
                                description: "This table displays all the data used for the graph. The specific data is the AI usage cost of a specified cluster. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownData, category: "Node", isDelta: false, isAverage: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                    }
                    //MARK: All clusters
                    //Graph and Table of cluster aggregation
                    else {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(title: "Cluster Cost-Time Graph (2026)", description: nil).padding(.top)
                            
                            genericGraph(data: appData.drilldownData, ylabel: "Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(title: "Cluster Cost Table (2026)", description: "This table displays all the data used for the graph. The specific data is AI usage cost for all clusters in the cluster catagory. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownData, category: "Cluster", isDelta: false, isAverage: false)
                             .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                    }
                //MARK: Average Cost
                } else {
                    
                    
                    //MARK: Specific cluster's node
                    //Graph and DataTable of a specific cluster and node in cluster
                    if appData.clusterId != nil && appData.nodeId != nil {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(
                                title: "Node \(appData.drillFilterNode.label) Average Cost-Time Graph (2026)", description: nil).padding(.top)
                            
                            genericGraph(data: appData.drilldownAverageData, ylabel: "Average Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(
                                title: "Node \(appData.drillFilterNode.label) Average Cost Table (2026)",
                                description: "This table displays all the data used for the graph. The specific data is the AI usage average cost of a node in a specified cluster. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownAverageData, category: "Query Type", isDelta: false, isAverage: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                                                
                        
                    //MARK: Specific cluster
                    //Graph and Table of a specific cluster
                    } else if appData.clusterId != nil {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(
                                title: "Cluster \(appData.drillFilterCluster.rawValue) Average Cost-Time Graph (2026)", description: nil)
                            .padding(.top)
                            
                            genericGraph(data: appData.drilldownAverageData, ylabel: "Average Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(
                                title: "Cluster \(appData.drillFilterCluster.rawValue) Average Cost Table (2026)",
                                description: "This table displays all the data used for the graph. The specific data is the AI usage average cost of a specified cluster. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownAverageData,category: "Node", isDelta: false, isAverage: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    //MARK: All clusters
                    //Graph and Table of cluster aggregation
                    } else {
                        //Graph
                        if appData.viewType == .graph {
                            DrillDownTitleAndButtonLayout(title: "Cluster Average Cost-Time Graph (2026)", description: nil).padding(.top)
                            
                            genericGraph(data: appData.drilldownAverageData, ylabel: "Average Cost (¢)", isDelta: false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Table
                        } else {
                            DrillDownTitleAndButtonLayout(
                                title: "Cluster Average Cost DTable (2026)",
                                description: "This table displays all the data used for the graph. The specific data is AI usage cost for all clusters in the cluster catagory. Each row is a AI usage record containing the date, the categories of the record (if avaliable), and cost of record as USD, Euro, and raw cost (US cents).").padding(.top)
                            
                            genericDataTable(data: appData.drilldownAverageData, category: "Cluster", isDelta: false, isAverage: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        
                    }
                }
            }.frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}
