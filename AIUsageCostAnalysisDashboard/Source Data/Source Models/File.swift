//
//  FileModel.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import Cocoa
import SwiftUI

//MARK: File Model
struct File: Codable, Sendable {
     let clusters: [clusters]
     let nodes: [nodes]
     let models: [models]
     let records: [records]
}
//MARK: Cluster section
struct clusters: Codable, Identifiable, Sendable {
     let id: String
     let name: String
     let region: String
}
//MARK: Node section
struct nodes: Codable, Identifiable, Sendable {
     let id: String
     let clusterId: String
     let name: String
     let size: String
}
//MARK: Model section
struct models: Codable, Identifiable, Sendable {
     let id: String
     let displayName: String
     let provider: String
     let isLocal: Bool
}
//MARK: Records section
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
