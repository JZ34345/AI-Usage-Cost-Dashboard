//
//  Route.swift
//  AIUsageCostAnalysisDashboard
//
//  Created by Jason Zhang on 8/6/26.
//
import Hummingbird
import Foundation

struct CostRoutes: Sendable {
    let loader: ServerDataLoader
    
    //Test signal ping -> pong
    func ping(_ request: Request, context: BasicRequestContext) async throws -> String {return "pong"}
    
    //Get metadata from server
    func getMetaData(_ request: Request, context: BasicRequestContext) async throws -> Response {
        let cluster =  await loader.fileData?.clusters ?? []
        let node = await loader.fileData?.nodes ?? []
        let model = await loader.fileData?.models ?? []
        
        let output = FileOutput(
            clusters: cluster.map {
                ClusterOutput(id: $0.id, name: $0.name, region: $0.region)
            },
            nodes: node.map {
                NodeOutput(id: $0.id, clusterId: $0.clusterId, name: $0.name, size: $0.size)
            },
            models: model.map {
                ModelOutput(id: $0.id, displayName: $0.displayName, provider: $0.provider, isLocal: $0.isLocal)
            }
        )
        let data  = try JSONEncoder().encode(output)
        
        return Response(status: .ok, headers: [.contentType: "application/json"], body: .init(byteBuffer: ByteBuffer(bytes: data)))
    }
    
    //Get cost data from server
    func getCosts(_ request: Request, context: BasicRequestContext) async throws -> Response {
        let params = request.uri.queryParameters
        let startDate = params["startDate"].map(String.init)
        let endDate = params["endDate"].map(String.init)
        let groupBy = params["groupBy"].map(String.init) ?? "total"
        let clusterId = params["clusterId"].map(String.init)
        let nodeId = params["nodeId"].map(String.init)
        
        async let filtered = loader.filterRecords(startDate: startDate, endDate: endDate, clusterId: clusterId, nodeId: nodeId)
        async let clusterLookup = loader.clusterLookup
        async let nodeLookup = loader.nodeLookup
        async let modelLookup = loader.modelLookup
        
        let summaries = await loader.aggregateRecords(filtered, groupBy: groupBy,
                                                clusterLookup: clusterLookup,
                                                modelLookup: modelLookup,
                                                nodeLookup: nodeLookup
        )
        
        let data = try JSONEncoder().encode(summaries)
        return Response(status: .ok, headers: [.contentType: "application/json"], body: .init(byteBuffer: ByteBuffer(bytes: data)))
    }
    
    //Get DrillDown specific data from server
    func getDrillDown(_ request: Request, context: BasicRequestContext) async throws -> Response {
        let params = request.uri.queryParameters
        let clusterId = params["clusterId"].map(String.init)
        let nodeId = params["nodeId"].map(String.init)
        let startDate = params["startDate"].map(String.init)
        let endDate = params["endDate"].map(String.init)
        
        let groupBy: String
        
        if nodeId != nil && clusterId != nil {
            groupBy = "queryType"
        } else if clusterId != nil {
            groupBy = "node"
        } else {
            groupBy = "cluster"
        }
        
        async let filtered = loader.filterRecords(startDate: startDate, endDate: endDate, clusterId: clusterId, nodeId: nodeId)
        
        async let clusterLookup = loader.clusterLookup
        async let nodeLookup = loader.nodeLookup
        async let modelLookup = loader.modelLookup
        
        let summaries = await loader.aggregateRecords(filtered, groupBy: groupBy,
                                                clusterLookup: clusterLookup,
                                                modelLookup: modelLookup,
                                                nodeLookup: nodeLookup
        )
        
        let data = try JSONEncoder().encode(summaries)
        return Response(status: .ok, headers: [.contentType: "application/json"], body: .init(byteBuffer: ByteBuffer(bytes: data)))
    }
}
