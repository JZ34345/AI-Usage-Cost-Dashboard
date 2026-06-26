//
//  AppData.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/24/26.
//
import Cocoa
import SwiftUI
import Charts


@Observable class AppData {
    //MARK: Source data and category lookups
    let source: GraphDataSource
    let clusterLookUp: [String: String]
    let modelLookUp: [String: String]
    let nodeLookUp: [String: String]
    
    init(source: GraphDataSource) {
        self.source = source
        self.clusterLookUp = Dictionary(uniqueKeysWithValues: source.clusters.map { ($0.id, $0.region) })
        self.modelLookUp = Dictionary(uniqueKeysWithValues: source.models.map {($0.id, $0.displayName)})
        self.nodeLookUp = Dictionary(uniqueKeysWithValues: source.nodes.map {($0.id, $0.name)})
    }

    //MARK: Filters
    var mainFilter: FilterButton.FilterOptions = .total
    
    //Arranges filter choice to a data format for use in groupby parameter in makeGenericData function
    func groupByClosure(for category: FilterButton.FilterOptions) -> (records) -> String {
       
       
       switch category {
           case .cluster : return {record in self.clusterLookUp[record.clusterId] ?? "Unknown"}
           case .query: return {record in record.queryType}
           case .model: return {record in self.modelLookUp[record.modelId] ?? "Unknown"}
           case .wow: return {_ in "WoW"}
           default: return {_ in "Total"}
       }

   }
    
    //MARK: Date Filter
    var dateFilter: DateFilterButton.DataFilterOptions = .seven
    var datePicker = false
    var startDate = "Start Date (yyyy-MM-dd)"
    var endDate = "End Date (yyyy-MM-dd)"
    
    // date closure function to rearrange date info in proper type
    func dateByClosure(for period: DateFilterButton.DataFilterOptions) -> Int {
        switch period {
            case .seven: return 7
            case .thirty: return 30
            case .ninety: return 90
            default: return 30
        }
    }

     func dateRangeFilter(option: DateFilterButton.DataFilterOptions, start: String, end: String) -> (records) -> Bool {
        let formatter = ISO8601DateFormatter()
        let calendar = Calendar.current
         let mostRecentDate = source.records.compactMap { formatter.date(from: $0.day) }.max() ?? Date()
        
        //arranges each filter choice to a filter in format for use in makeGenericData function
        switch option {
        case .seven:
            let cutoff = calendar.date(byAdding: .day, value: -7, to: mostRecentDate)!
            return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
        case .thirty:
            let cutoff = calendar.date(byAdding: .day, value: -30, to: mostRecentDate)!
            return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
        case .ninety:
            let cutoff = calendar.date(byAdding: .day, value: -90, to: mostRecentDate)!
            return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
        case .custom:
            let dayFormatter = DateFormatter()
            dayFormatter.dateFormat = "yyyy/MM/dd"
            
            guard let start = dayFormatter.date(from: start),
                  let end  = dayFormatter.date(from: end)
            else {
                return {_ in true}
            }
            return {record in
                let date = formatter.date(from: record.day) ?? .distantPast
                return date >= start && date <= end
            }
        }
    }

    
    
    //MARK: Drill Down
    var drillFilterCluster: DrillDownButton.DrillDownClusterOptions = .inital
    var drillFilterNode: DrillNodeButton.DrillDownNodeOptions = .inital
    let clusterId: String? = nil
    
    let data: [GenericSummary] = []
    
    //MARK: Graph data templates
    var totalGraphData: [GenericSummary] {
        makeGenericGraph(record: source.records,
                         filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         groupBy: groupByClosure(for: mainFilter),
                         metric: {$0.costCents},
                         dayLimit: dateByClosure(for: dateFilter),
                         applyDayLimit: dateFilter != .custom
        )
    }
    
    var WoWGraphData: [GenericSummary] {
        makeGenericGraph(record: source.records,
                        filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                        groupBy: groupByClosure(for: mainFilter),
                        metric: {$0.costCents},
                        dayLimit: dateByClosure(for: dateFilter),
                        applyDayLimit: dateFilter != .custom,
                        groupWeek: true,
                        delta: true
        )
    }
    
    
    //MARK: Graph Showcase graphs
    var clusterAverageGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                metric: {$0.costCents / Double($0.queryCount)}, dayLimit: 30 )
    }
    
    var clusterGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                metric: {$0.costCents}, dayLimit: 30 )
    }
    
    var modelAverageGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                metric: {$0.costCents / Double($0.queryCount)}, dayLimit: 30)
    }
    
    var modelGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                metric: {$0.costCents}, dayLimit: 30)
    }
    
    var drillClusterData: [GenericSummary] {
        let target = source.clusters.first {$0.region == "us-west-1"}?.id
        
        return makeGenericGraph(record: source.records,
                                filter: {record in record.clusterId == target },
                                groupBy: {nodeLookUp[$0.nodeId] ?? "Unknown"},
                                metric: {$0.costCents},
                                dayLimit: 30)
    }
    
    var drillNodeData: [GenericSummary] {
        let target = source.clusters.first {$0.region == "us-west-1"}?.id
        let target2 = source.nodes.first {$0.name == "usw-medium-02"}?.id

        return makeGenericGraph(record: source.records,
                                filter: {record in record.clusterId == target && record.nodeId == target2 },
                                groupBy: {records in records.queryType},
                                metric: {$0.costCents},
                                dayLimit: 30)
    }
    
    var errorData: [GenericSummary] {
        return makeGenericGraph(record:source.records, metric: {$0.costCents}, dayLimit: 0)
    }
}
