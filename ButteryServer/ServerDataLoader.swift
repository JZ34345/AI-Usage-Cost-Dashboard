//
//  ServerDataLoader.swift
//  AIUsageCostAnalysisDashboard
//
//  Created by Jason Zhang on 8/6/26.
//
import Foundation

actor ServerDataLoader {
    private(set) var fileData: ServerFile?
    
    static func load() async throws -> ServerDataLoader {
            let loader = ServerDataLoader()
        try await loader.loadData()
        return loader
    }
    
    private init() {}
    
    func loadData() async throws {
        // Find sample-data.json relative to the executable
        // Works for server targets where Bundle.main has no resources
        let possiblePaths = [
            "./sample-data.json",                           // same directory as executable
            "../Resources/sample-data.json",               // Resources folder
            "Buttery_Internship/sample-data.json"          // relative to project root
        ]
        
        var fileURL: URL? = nil
        for path in possiblePaths {
            let url = URL(fileURLWithPath: path)
            if FileManager.default.fileExists(atPath: url.path) {
                fileURL = url
                break
            }
        }
        
        guard let url = fileURL else {
            print("Could not find sample-data.json — tried paths: \(possiblePaths)")
            throw FileError.fileNotFound(" ")
        }
        
        let data = try Data(contentsOf: url)
        fileData = try JSONDecoder().decode(ServerFile.self, from: data)
        print("Loaded \(fileData?.records.count ?? 0) records from \(url.path)")
    }

    func aggregateRecords(
        _ records: [ServerRecord],
        groupBy: String,
        clusterLookup: [String: String],
        modelLookup: [String: String],
        nodeLookup: [String: String]
    ) -> [CostSummaryOutput] {
        let grouped = Dictionary(grouping: records) { record -> String in
            switch groupBy {
            case "cluster": return clusterLookup[record.clusterId] ?? "Unknown"
            case "model": return modelLookup[record.modelId] ?? "Unknown"
            case "node": return nodeLookup[record.nodeId] ?? "Unknown"
            case "queryType": return record.queryType
            default: return "Total"
            }
        }
        
        return grouped.flatMap {category, records in
            Dictionary(grouping: records) { $0.day }.map { day, dayRecords in
                CostSummaryOutput(day: day, category: category,
                                  totalCost: dayRecords.reduce(0.0) {$0 + $1.costCents},
                                  queryCount: dayRecords.reduce(0) {$0 + $1.queryCount})
            }
        }.sorted {$0.day < $1.day}
    }
    
    func filterRecords(
        startDate: String?,
        endDate: String?,
        clusterId: String?,
        nodeId: String?
    ) -> [ServerRecord] {
        guard let records = fileData?.records else {return []}
        
        return records.filter { record in
            if let start = startDate, record.day < start {return false}
            if let end = endDate, record.day > end {return false}
            if let cluster = clusterId, record.clusterId != cluster {return false}
            if let node = nodeId, record.nodeId != node {return false}
            return true
        }
    }
    
    //Lookup tables
    var clusterLookup: [String: String] {
        Dictionary(uniqueKeysWithValues: (fileData?.clusters ?? []).map {($0.id, $0.name)})
    }
    
    var modelLookup: [String: String] {
        Dictionary(uniqueKeysWithValues: (fileData?.models ?? []).map {($0.id, $0.displayName)})
    }
    
    var nodeLookup: [String: String] {
        Dictionary(uniqueKeysWithValues: (fileData?.nodes ?? []).map {($0.id, $0.name)})
    }
}
