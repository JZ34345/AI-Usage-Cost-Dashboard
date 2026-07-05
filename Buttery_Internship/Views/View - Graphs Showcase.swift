//
//  View - Graphs Showcase.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/23/26.
//
import Cocoa
import Cocoa
import SwiftUI
import Charts
//MARK: Graph Showcase
struct GraphShowcase: View {
    @Environment(AppData.self) private var appData
    
     var body: some View {
        ScrollView([.vertical]) {
            VStack {
                VStack {
                    //MARK: View switch button
                    Text("Graph Showcase").font(.largeTitle)
                    ViewButton()
                }
                //MARK: Filter and date filter button
                HStack {
                    FilterButton()
                    DateFilterButton()
                }.padding()
                
                Spacer(minLength: 150)

                
                //MARK: Graph arrangement
                VStack {
                    HStack {
                        //MARK: Cluster
                        genericGraph(data: appData.clusterGraphData,
                                    title: "Cluster Cost-Time Graph (2026)",
                                    ylabel: "Cost (Cents)",
                                    isDelta: false)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.clusterGraphData,
                                        title: "Cluster Cost-Time Table",
                                        category: "Cluster",
                                        isDelta: false,
                                        isAverage: false)
                        .frame(maxWidth: .infinity)

                    }
                    
                    Spacer(minLength: 150)

                    HStack {
                        //MARK: Cluster Average
                        genericGraph(data: appData.clusterAverageGraphData,
                                    title: "Cluster Average Cost-Time Graph (2026)",
                                    ylabel: "Cost (Cents)",
                                    isDelta: false)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.clusterAverageGraphData,
                                        title: "Cluster Average Cost-Time Table",
                                        category: "Cluster",
                                        isDelta: false,
                                        isAverage: true)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        //MARK: Model
                        genericGraph(data: appData.modelGraphData,
                                      title: "Model Cost-Time Graph (2026)",
                                      ylabel: "Average Cost (Cents)",
                                      isDelta: false,)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.modelGraphData,
                                          title: "Model Cost-Time Table",
                                          category: "ModelId",
                                          isDelta: false,
                                          isAverage: true)
                        .frame(maxWidth: .infinity)
                    }

                    Spacer(minLength: 150)

                    HStack {
                        //MARK: Model Average
                        genericGraph(data: appData.modelAverageGraphData,
                                      title: "Model Average Cost-Time Graph (2026)",
                                      ylabel: "Average Cost (Cents)",
                                      isDelta: false)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.modelAverageGraphData,
                                          title: "Model Average Cost-Time Table",
                                          category: "ModelId",
                                          isDelta: false,
                                          isAverage: false)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                                        
                    HStack {
                        //MARK: Graph error view
                        genericGraph(data: appData.errorData, title: " ", ylabel: " ", isDelta: false)
                            .frame(maxWidth: .infinity)
                            
                        Divider()
                        
                        genericDataTable(data: appData.errorData,
                                         title: " ",
                                         category: " ",
                                         isDelta: false,
                                         isAverage: false)
                            .frame(maxWidth: .infinity)
                    }
                    
                    HStack {
                        //MARK: DrillDown US West Cluster
                        genericGraph(data: appData.drillClusterData,
                                     title: "US West Nodes Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.drillClusterData,
                                         title: "US West Nodes DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: false)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer(minLength: 150)
                    
                    HStack {
                        //MARK: DrillDown US West Node
                        genericGraph(data: appData.drillNodeData,
                                     title: "US West Node Query Cost-Time Graph (2026)",
                                     ylabel: "Cost (Cents)",
                                     isDelta: false)
                            .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        genericDataTable(data: appData.drillNodeData,
                                         title: "US West Node Query DataTable",
                                         category: "Node",
                                         isDelta: false,
                                         isAverage: false)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
    
}

