//
//  DrillDownView.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/22/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

public struct DrillDown: View {
    
    @State var showDrillCluster: DrillDownButton.DrillDownClusterOptions = .inital
    @State var dateFilter: DateFilterButton.DataFilterOptions = .seven
    @State var startDate = "Start Date (yyyy-MM-dd)"
    @State var endDate = "End Date (yyyy-MM-dd)"
    
    var clusterId: String? {
        switch showDrillCluster {
        case .inital: return nil
        case .usWest: return sampleData.clusters.first {$0.region == "us-west-1"}?.id
        case .usEast: return sampleData.clusters.first {$0.region == "us-east-1"}?.id
        case .europeWest: return sampleData.clusters.first {$0.region == "eu-west-1"}?.id
        }
    }
    
    var drilldownData: [GenericSummary] {
        let dates = dateRangeFilter(option: dateFilter, start: startDate, end: endDate)
        
        if let clusterId = clusterId {
            let nodeLookUp = Dictionary(uniqueKeysWithValues: sampleData.nodes.map {($0.id, $0.name)})
            return makeGenericGraph(filter: {records in dates(records) && records.clusterId == clusterId},
                                    groupBy: {records in nodeLookUp[records.nodeId] ?? "Unknown"},
                                    metric: {$0.costCents}, dayLimit: dateByClosure(for: dateFilter))
        }
        //Convert to node --> querytype data, replace cluster
        else {
            let clusterLookup = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.name) })
            return makeGenericGraph(groupBy: { record in clusterLookup[record.clusterId] ?? "Unknown" },
                                    metric: { $0.costCents },
                                    dayLimit: dateByClosure(for: dateFilter)
            )
        }
    }
    
    public var body: some View {
        ScrollView([.vertical]) {
            VStack {
                HStack {
                    Spacer()
                    CSVExport(data: drilldownData)
                    
                }
                Text("Test").font(.title)
                HStack {
                    DrillDownButton(showDrillFilter: $showDrillCluster)//.onChange(of: showDrillCluster) {showDrillNode = .inital}
                    DateFilterButton(showDateFilter: $dateFilter, startDate: $startDate, endDate: $endDate)
                }.padding()
                
                HStack {
                    genericGraph(data: drilldownData,
                                 title: "Test",
                                 ylabel: "Cost (Cents)",
                                 isDelta: false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    Divider()
                    genericDataTable(data: drilldownData,
                                     title: "Test",
                                     category: showDrillCluster.rawValue,
                                     isDelta: false)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer()
            }
            .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
    }
}
