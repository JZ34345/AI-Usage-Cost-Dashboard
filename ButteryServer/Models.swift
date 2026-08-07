//
//  Models.swift
//  AIUsageCostAnalysisDashboard
//
//  Created by Jason Zhang on 8/6/26.
//
import Foundation
//MARK: Input
struct ServerRecord: Codable {
    let id: String
    let day: String
    let clusterId: String
    let nodeId: String
    let queryType: String
    let modelId: String
    let queryCount: Int
    let tokensIn: Int
    let tokensOut: Int
    let totalDurationMs: Int
    let costCents: Double
}

struct ServerCluster: Codable {
     let id: String
     let name: String
     let region: String
}
struct ServerNodes: Codable {
     let id: String
     let clusterId: String
     let name: String
     let size: String
}

struct ServerModels: Codable {
     let id: String
     let displayName: String
     let provider: String
     let isLocal: Bool
}

struct ServerFile: Codable {
     let clusters: [ServerCluster]
     let nodes: [ServerNodes]
     let models: [ServerModels]
     let records: [ServerRecord]
}

//MARK: Server Output
struct CostSummaryOutput: Codable {
    let day: String
    let category: String
    let totalCost: Double
    let queryCount: Int
}

struct ClusterOutput: Codable {
     let id: String
     let name: String
     let region: String
}
struct NodeOutput: Codable {
     let id: String
     let clusterId: String
     let name: String
     let size: String
}

struct ModelOutput: Codable {
     let id: String
     let displayName: String
     let provider: String
     let isLocal: Bool
}

struct FileOutput: Codable {
     let clusters: [ClusterOutput]
     let nodes: [NodeOutput]
     let models: [ModelOutput]
}

