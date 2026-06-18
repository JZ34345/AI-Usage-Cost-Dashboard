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


public struct file: Codable, Sendable {
    public let clusters: [clusters]
    public let nodes: [nodes]
    public let models: [models]
    let records: [records]
}

public struct clusters: Codable, Identifiable, Sendable {
    public let id: String
    public let name: String
    public let region: String
}

public struct nodes: Codable, Identifiable, Sendable {
    public let id: String
    public let clusterId: String
    public let name: String
    public let size: String
}

public struct models: Codable, Identifiable, Sendable {
    public let id: String
    public let displayName: String
    public let provider: String
    public let isLocal: Bool
}

struct records: Codable, Identifiable, Sendable {
    public let id: String
    public let day: String
    public let clusterId: String
    public let nodeId: String
    public let queryType: String
    public let modelId: String
    public let queryCount: Int
    public let tokensIn: Int
    public let tokensOut: Int
    public let totalDurationMs: Int
    public let costCents: Double
}
//Read JSON File
public extension Bundle {
    func loadFile<T: Decodable>(_ fileName: String) -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Step 1 fail")
            fatalError("Error: couldn't find file.")
        }
        
        
        guard let data = try? Data(contentsOf: url) else {
            print("Step 2 fail")
            fatalError("Error: failed to load file")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("Step 3 fail")
            fatalError("Failed to decode")
        }
    }
}

public let sampleData: file = Bundle.main.loadFile("sample-data")
