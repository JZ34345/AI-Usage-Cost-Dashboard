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
    
    
    private var _totalGraphDataCache: [GenericSummary]?
    private var _drillDownGraphDataCache: [GenericSummary]?
    private var _categoryGraphDataCache: [GenericSummary]?
    private var _WoWGraphDataCache: [GenericSummary]?
    private var _categorytWoWGraphDataCache: [GenericSummary]?
    private var _totalGraphAverageDataCache: [GenericSummary]?
    private var _drillDownGraphAverageDataCache: [GenericSummary]?
    private var _categoryGraphAverageDataCache: [GenericSummary]?
    private var _WoWGraphAverageDataCache: [GenericSummary]?
    
    private var currentFilters: FilterState {
        FilterState(mainFilter: mainFilter, dateFilter: dateFilter, startDate: startDate, endDate: endDate,                      drillCluster: drillFilterCluster, drillNode: drillFilterNode)
    }
    
    private var lastFilters: FilterState?
    
    private func invalidateCache() {
        _totalGraphDataCache = nil
        _drillDownGraphDataCache = nil
        _categoryGraphDataCache = nil
        _WoWGraphDataCache = nil
        _categorytWoWGraphDataCache = nil
        _totalGraphAverageDataCache = nil
        _drillDownGraphAverageDataCache = nil
        _categoryGraphAverageDataCache = nil
        _WoWGraphAverageDataCache = nil
    }
    
    private func cached<T>(_ cache: inout T?, compute: () -> T) -> T {
        if let current = cache {
            return current
        }
        let generic = compute()
        return generic
    }
    
    //MARK: View switcher
    var viewSwitcher: ViewButton.ViewSwitcher = .overview

    //MARK: Filters
    var mainFilter: FilterButton.FilterOptions = .total {didSet {invalidateCache()}}
    
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
    var dateFilter: DateFilterButton.DataFilterOptions = .seven {didSet {invalidateCache()
                                                                         validCustomDates()}}
    var datePicker = false
    var startDate = "Start Date (yyyy-MM-dd)" {didSet {invalidateCache()
                                                       validCustomDates()}}
    var endDate = "End Date (yyyy-MM-dd)" {didSet {invalidateCache()
                                                   validCustomDates()}}
    var datePickerError: String? = nil
    
    private func validCustomDates() {
        guard dateFilter == .custom else {
            datePickerError = nil
            return
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let start = "Start Date (yyyy-MM-dd)"
        let end = "End Date (yyyy-MM-dd)"
        
        guard startDate != start && endDate != end else {
            datePickerError = nil
            return
        }
        
        let validStart = formatter.date(from: startDate) != nil
        let validEnd = formatter.date(from: endDate) != nil
        
        if !validStart && !validEnd {
            datePickerError = "Incorrect start and end dates - use yyyy-MM-dd"
        } else if !validStart {
            datePickerError = "Incorrect start date - use yyyy-MM-dd"
        } else if !validEnd {
            datePickerError = "Incorrect end date - use yyyy-MM-dd"
        } else {
            datePickerError = nil
        }
    }
    
    
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
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let mostRecentDate = source.records.compactMap { source.cachedDates[$0.day] }.max() ?? Date()
    
    //arranges each filter choice to a filter in format for use in makeGenericData function
    switch option {
    case .seven:
        let cutoff = calendar.date(byAdding: .day, value: -7, to: mostRecentDate)!
        return {record in (self.source.cachedDates[record.day] ?? .distantPast) >= cutoff}
    case .thirty:
        let cutoff = calendar.date(byAdding: .day, value: -30, to: mostRecentDate)!
        return {record in (self.source.cachedDates[record.day] ?? .distantPast) >= cutoff}
    case .ninety:
        let cutoff = calendar.date(byAdding: .day, value: -90, to: mostRecentDate)!
        return {record in (self.source.cachedDates[record.day] ?? .distantPast) >= cutoff}
    case .custom:
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy/MM/dd"
        
        guard let start = dayFormatter.date(from: start),
                let end  = dayFormatter.date(from: end)
        else {
            return {_ in true}
        }
        return {record in
            let date = self.source.cachedDates[record.day] ?? .distantPast
            return date >= start && date <= end
        }
    }
}
    
    //MARK: Drill Down
    var drillFilterCluster: DrillDownButton.DrillDownClusterOptions = .inital {didSet {invalidateCache()}}
    var drillFilterNode: DrillNodeButton.DrillDownNodeOptions = .inital {didSet {invalidateCache()}}
    
    let data: [GenericSummary] = []
    
    //Links cluster enum to the string name of cluster in sample data
    var clusterId: String? {
        switch drillFilterCluster {
        case .inital: return nil
        case .usWest: return source.clusters.first {$0.region == "us-west-1"}?.id
        case .usEast: return source.clusters.first {$0.region == "us-east-1"}?.id
        case .europeWest: return source.clusters.first {$0.region == "eu-west-1"}?.id
        }
    }
    
    //Links node enum to the string name of each node in sample data
    var nodeId: String? {
        if case .node(let id, name: _) = drillFilterNode { return id }
        return nil
    }
    
    //MARK: Graph data templates
    var totalGraphData: [GenericSummary] {
        cached(&_totalGraphDataCache) {
            makeGenericGraph(record: source.records,
                                           selectedDates: source.cachedDates,
                                           filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                                           metric: {($0.costCents * 100).rounded() / 100},
                                           dayLimit: dateByClosure(for: dateFilter),
                                           applyDayLimit: dateFilter != .custom
            )
        }
    }
    
    var WoWGraphData: [GenericSummary] {
        cached(&_WoWGraphDataCache) {
            makeGenericGraph(record: source.records,
                             selectedDates: source.cachedDates,
                             filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                             metric: {($0.costCents * 100).rounded() / 100},
                             dayLimit: dateByClosure(for: dateFilter),
                             applyDayLimit: dateFilter != .custom,
                             groupWeek: true,
                             delta: true
            )
        }
    }
    
    var categoryGraphData: [GenericSummary] {
        cached(&_categoryGraphDataCache) {
            makeGenericGraph(record: source.records,
                             selectedDates: source.cachedDates,
                             filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                             groupBy: groupByClosure(for: mainFilter),
                             metric: {($0.costCents * 100).rounded() / 100},
                             dayLimit: dateByClosure(for: dateFilter),
                             applyDayLimit: dateFilter != .custom
            )
        }
    }
    
    var categoryWoWGraphData: [GenericSummary] {
        cached(&_categorytWoWGraphDataCache) {
            makeGenericGraph(record: source.records,
                             selectedDates: source.cachedDates,
                             filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                             groupBy: groupByClosure(for: mainFilter),
                             metric: {($0.costCents * 100).rounded() / 100},
                             dayLimit: dateByClosure(for: dateFilter),
                             applyDayLimit: dateFilter != .custom,
                             groupWeek: true,
                             delta: true
            )
        }
    }
    
    //MARK: Average Graph data templates
    var averageTotalGraphData: [GenericSummary] {
        cached(&_totalGraphAverageDataCache) {
            makeGenericGraph(record: source.records,
                             selectedDates: source.cachedDates,
                             filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                             groupBy: groupByClosure(for: mainFilter),
                             metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                             dayLimit: dateByClosure(for: dateFilter),
                             applyDayLimit: dateFilter != .custom
            )
        }
    }
    
    var averageWoWGraphData: [GenericSummary] {
        cached(&_WoWGraphAverageDataCache) {
            makeGenericGraph(record: source.records,
                             selectedDates: source.cachedDates,
                             filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                             groupBy: groupByClosure(for: mainFilter),
                             metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                             dayLimit: dateByClosure(for: dateFilter),
                             applyDayLimit: dateFilter != .custom,
                             groupWeek: true,
                             delta: true
            )
        }
    }
    
    //MARK: DrillDown data
    //Create the drilldown data based on the selected cluster and nodes
    var drilldownData: [GenericSummary] {
        cached(&_drillDownGraphDataCache) {
            let dates = dateRangeFilter(option: dateFilter,
                                        start: startDate,
                                        end: endDate)
            
            //Filter by specific cluster and node in that cluster
            if let clusterId = clusterId, let nodeId = nodeId {
                return makeGenericGraph(record: source.records,
                                           selectedDates: source.cachedDates,
                                           filter: {records in dates(records) &&
                    records.clusterId == clusterId &&
                    records.nodeId == nodeId},
                                           groupBy: { records in records.queryType },
                                           metric: {($0.costCents * 100).rounded() / 100},
                                           dayLimit: dateByClosure(for: dateFilter)
                )
            }
            //Filter by specific cluster
            else if let clusterId = clusterId {
                let nodeLookUp = Dictionary(uniqueKeysWithValues: source.nodes.map {($0.id, $0.name)})
                return makeGenericGraph(record: source.records,
                                           selectedDates: source.cachedDates,
                                           filter: {records in dates(records) && records.clusterId == clusterId},
                                           groupBy: {records in nodeLookUp[records.nodeId] ?? "Unknown"},
                                           metric: {($0.costCents * 100).rounded() / 100},
                                           dayLimit: dateByClosure(for: dateFilter))
            }
            //No filter, groupby aggregation on clusters
            else {
                let clusterLookUp = Dictionary(uniqueKeysWithValues: source.clusters.map { ($0.id, $0.name) })
                return makeGenericGraph(record: source.records,
                                           selectedDates: source.cachedDates,
                                           filter: {records in dates(records)},
                                           groupBy: { record in clusterLookUp[record.clusterId] ?? "Unknown" },
                                           metric: {($0.costCents * 100).rounded() / 100},
                                           dayLimit: dateByClosure(for: dateFilter)
                )
            }
        }
    }
    //MARK: Average Drilldown Data
    var drilldownAverageData: [GenericSummary] {
        cached(&_drillDownGraphAverageDataCache) {
            let dates = dateRangeFilter(option: dateFilter,
                                        start: startDate,
                                        end: endDate)
            
            //Filter by specific cluster and node in that cluster
            if let clusterId = clusterId, let nodeId = nodeId {
                return makeGenericGraph(record: source.records,
                                        selectedDates: source.cachedDates,
                                        filter: {records in dates(records) &&
                    records.clusterId == clusterId &&
                    records.nodeId == nodeId},
                                        groupBy: { records in records.queryType },
                                        metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                                        dayLimit: dateByClosure(for: dateFilter)
                )
            }
            //Filter by specific cluster
            else if let clusterId = clusterId {
                let nodeLookUp = Dictionary(uniqueKeysWithValues: source.nodes.map {($0.id, $0.name)})
                return makeGenericGraph(record: source.records,
                                        selectedDates: source.cachedDates,
                                        filter: {records in dates(records) && records.clusterId == clusterId},
                                        groupBy: {records in nodeLookUp[records.nodeId] ?? "Unknown"},
                                        metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                                        dayLimit: dateByClosure(for: dateFilter))
            }
            //No filter, groupby aggregation on clusters
            else {
                let clusterLookUp = Dictionary(uniqueKeysWithValues: source.clusters.map { ($0.id, $0.name) })
                return makeGenericGraph(record: source.records,
                                        selectedDates: source.cachedDates,
                                        filter: {records in dates(records)},
                                        groupBy: { record in clusterLookUp[record.clusterId] ?? "Unknown" },
                                        metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                                        dayLimit: dateByClosure(for: dateFilter)
                )
            }
        }
    }
    
    
    //MARK: Graph Showcase graphs
    var clusterAverageGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100},
                                dayLimit: 30 )
    }
    
    var clusterGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                groupBy: {clusterLookUp[$0.clusterId] ?? "Unknown"},
                                metric: {($0.costCents * 100).rounded() / 100}, dayLimit: 30 )
    }
    
    var modelAverageGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                metric: {(($0.costCents / Double($0.queryCount)) * 100).rounded() / 100}, dayLimit: 30)
    }
    
    var modelGraphData: [GenericSummary] {
        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                groupBy: {modelLookUp[$0.modelId] ?? "Unknown"},
                                metric: {($0.costCents * 100).rounded() / 100}, dayLimit: 30)
    }
    
    var drillClusterData: [GenericSummary] {
        let target = source.clusters.first {$0.region == "us-west-1"}?.id
        
        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                filter: {record in record.clusterId == target },
                                groupBy: {nodeLookUp[$0.nodeId] ?? "Unknown"},
                                metric: {($0.costCents * 100).rounded() / 100},
                                dayLimit: 30)
    }
    
    var drillNodeData: [GenericSummary] {
        let target = source.clusters.first {$0.region == "us-west-1"}?.id
        let target2 = source.nodes.first {$0.name == "usw-medium-02"}?.id

        return makeGenericGraph(record: source.records,
                                selectedDates: source.cachedDates,
                                filter: {record in record.clusterId == target && record.nodeId == target2 },
                                groupBy: {records in records.queryType},
                                metric: {($0.costCents * 100).rounded() / 100},
                                dayLimit: 30)
    }
    
    var errorData: [GenericSummary] {
        return makeGenericGraph(record:source.records, selectedDates: source.cachedDates, metric: {$0.costCents}, dayLimit: 0)
    }
}
