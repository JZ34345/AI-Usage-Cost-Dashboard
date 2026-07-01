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
// add a provider to the loadFile to differenciate between test and product information.
@Observable class GraphDataSource {
    private(set) var fileData: File?
    private(set) var dataError: String?
    private(set) var cachedDates: [String: Date] = [:]
    private(set) var fileProvider: any FileProvider
    
    init(provider: any FileProvider = FileCases.sampleData) {
        self.fileProvider = provider
        loadFile()
    }
    
    //Function that decodes, reads, and stores JSON file data into variable
    func loadFile() {
        //File name and extensions now dynamic and adjustable to FileProvider protocol and FileCases enum.
        guard let url = Bundle.main.url(forResource: fileProvider.fileName,
                                        withExtension: fileProvider.fileExtension)
        else {
            dataError = "Error: couldn't find file \(fileProvider.fileName).\(fileProvider.fileExtension)."
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            dataError = "Error: failed to load file \(fileProvider.fileName).\(fileProvider.fileExtension)"
            return
        }
        
        let decoder = JSONDecoder()
        //decode JSON file into File struct structure
        do {
            let decoded = try decoder.decode(File.self, from: data)
            fileData = decoded
            
            //Process dates from decoded file data
            let formatter = ISO8601DateFormatter()
            let uniqueDays = Set(decoded.records.map { $0.day })
            
            //Dates from decoded file cached for quicker loading
            cachedDates = Dictionary(uniqueKeysWithValues: uniqueDays.map {($0, formatter.date(from: $0) ?? Date())})
            
        } catch { dataError = "Failed to decode file \(fileProvider.fileName).\(fileProvider.fileExtension)" }
        
        //If there is a file avaliable, format the cached dates to unique days for the data's date range.
        if let fileData {
            let formatter = ISO8601DateFormatter()
            let uniqueDays = Set(fileData.records.map { $0.day })
            cachedDates = Dictionary(uniqueKeysWithValues: uniqueDays.map {($0, formatter.date(from: $0) ?? Date())})
        }
    }
    //Variables representing the different asscessible sections of the file data.
    var records: [records] {fileData?.records ?? []}
    var clusters: [clusters] {fileData?.clusters ?? []}
    var nodes: [nodes] {fileData?.nodes ?? []}
    var models: [models] {fileData?.models ?? []}
}
