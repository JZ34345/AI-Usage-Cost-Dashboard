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
    //Filters
    var mainFilter: FilterButton.FilterOptions = .total
    
    //Date Filters
    var dateFilter: DateFilterButton.DataFilterOptions = .seven
    var datePicker = false
    var startDate = "Start Date (yyyy-MM-dd)"
    var endDate = "End Date (yyyy-MM-dd)"
    
    
    //Drill Down
    var drillFilterCluster: DrillDownButton.DrillDownClusterOptions = .inital
    var drillFilterNode: DrillNodeButton.DrillDownNodeOptions = .inital
    let clusterId: String? = nil
    
    let data: [GenericSummary] = []
    
    //Graphdata templates
    var totalGraphData: [GenericSummary] {
        makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                         groupBy: groupByClosure(for: mainFilter),
                         metric: {$0.costCents},
                         dayLimit: dateByClosure(for: dateFilter),
                         applyDayLimit: dateFilter != .custom
        )
    }
    
    var WoWGraphData: [GenericSummary] {
        makeGenericGraph(filter: dateRangeFilter(option: dateFilter, start: startDate, end: endDate),
                        groupBy: groupByClosure(for: mainFilter),
                        metric: {$0.costCents},
                        dayLimit: dateByClosure(for: dateFilter),
                        applyDayLimit: dateFilter != .custom,
                        groupWeek: true,
                        delta: true
        )
    }
}
