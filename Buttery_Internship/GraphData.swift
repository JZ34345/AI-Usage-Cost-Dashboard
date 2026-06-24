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
 struct file: Codable, Sendable {
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
 extension Bundle {
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

 let sampleData: file = Bundle.main.loadFile("sample-data")
