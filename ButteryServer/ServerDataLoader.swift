//
//  ServerDataLoader.swift
//  AIUsageCostAnalysisDashboard
//
//  Created by Jason Zhang on 8/6/26.
//
import Foundation

class ServerDataLoader {
    private(set) var fileData: ServerFile?
    
    init() {
        do {
            let fileOutput = try loadData()
            // use fileOutput
        } catch FileError.fileNotFound(let name) {
            print("Couldn't find \(name).json")
        } catch FileError.couldNotLoadData(let name) {
            print("Couldn't load data from \(name).json")
        } catch FileError.couldNotDecode(let name) {
            print("Couldn't decode \(name).json")
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
    func loadData() throws -> FileOutput {
        //Finds the file name based on information given and stores in a constant
        guard let url = Bundle.main.url(forResource: "sample-data",
                                        withExtension: "json")
        else {
            throw FileError.fileNotFound("sample-data")
        }
        
        //Produces a constant of the data (undecoded) contained in url constant
        guard let data = try? Data(contentsOf: url) else {
            throw FileError.couldNotDecode("sample-data")
        }
        
        let decoder = JSONDecoder()
        //decode data constant of JSON file into File struct structure
        do {
            let decoded = try decoder.decode(FileOutput.self, from: data)
            return decoded
            
        } catch {
            throw FileError.couldNotLoadData("sample-data")
        }
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
            let byDay = Dictionary(grouping: records) { $0.day }
            return byDay.map { day, dayRecords in
                CostSummaryOutput(day: day, category: category, totalCost: dayRecords.reduce(0.0) {$0 + $1.costCents},
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
        }
    }
}
