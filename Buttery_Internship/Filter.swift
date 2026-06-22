//
//  Filter.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/19/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Filter
public struct FilterButton: View {
    //variable for what current filter choice is
    @Binding public var showSelectFilter: String
    
    //filter parameters
    public init(showSelectFilter: Binding<String>) {
        self._showSelectFilter = showSelectFilter
    }
    
    //filter choices
    public let FilterOptions = ["Total", "Cluster", "Query Type", "Model", "WoW"]
    
    //filter UI structure
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showSelectFilter = option
                }
                
            }
        } label: {
            Label(showSelectFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
    }
}

//Arranges filter choice to a data format for use in groupby parameter in makeGenericData function
public func groupByClosure(for category: String) -> (records) -> String {
    let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })
    let modelLookUp = Dictionary(uniqueKeysWithValues: sampleData.models.map {($0.id, $0.displayName)})
    
    switch category {
        case "Cluster": return {record in clusterLookUp[record.clusterId] ?? "Unknown"}
        case "Query Type": return {record in record.queryType}
        case "Model": return {record in modelLookUp[record.modelId] ?? "Unknown"}
        case "WoW": return {_ in "WoW"}
        default: return {_ in "Total"}
    }

}
