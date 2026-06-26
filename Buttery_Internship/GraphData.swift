//
//  GraphData.swift
//  
//
//  Created by Jason Zhang on 6/16/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: File Structure
struct File: Codable, Sendable {
     let clusters: [clusters]
     let nodes: [nodes]
     let models: [models]
     let records: [records]
}

 struct clusters: Codable, Identifiable, Sendable {
     let id: String
     let name: String
     let region: String
}

 struct nodes: Codable, Identifiable, Sendable {
     let id: String
     let clusterId: String
     let name: String
     let size: String
}

 struct models: Codable, Identifiable, Sendable {
     let id: String
     let displayName: String
     let provider: String
     let isLocal: Bool
}

 struct records: Codable, Identifiable, Sendable {
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
//MARK: Read JSON File
@Observable class GraphDataSource {
    private(set) var fileData: File?
    private(set) var dataError: String?
    
    init() {
        loadFile()
    }
    
    func loadFile() {
        guard let url = Bundle.main.url(forResource: "sample-data", withExtension: "json") else {
            dataError = "Error: couldn't find file."
            return
        }
        
        
        guard let data = try? Data(contentsOf: url) else {
            dataError = "Error: failed to load file"
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            fileData = try decoder.decode(File.self, from: data)
        } catch {
            dataError = "Failed to decode"
        }
    }
    
    var records: [records] {fileData?.records ?? []}
    var clusters: [clusters] {fileData?.clusters ?? []}
    var nodes: [nodes] {fileData?.nodes ?? []}
    var models: [models] {fileData?.models ?? []}
}
