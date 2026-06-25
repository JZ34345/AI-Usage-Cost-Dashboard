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
 struct FilterButton: View {
    //variable for what current filter choice is
    @Environment(AppData.self) private var appData

    //filter choices
     enum FilterOptions: String, CaseIterable {
        case total = "Total"
        case cluster = "Cluster"
        case model = "Model"
        case query = "Query Type"
        case wow = "WoW"
    }
    
    //filter UI structure
     var body: some View {
        Menu {
            ForEach(FilterOptions.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    appData.mainFilter = option
                }
                
            }
        } label: {
            Text(appData.mainFilter.rawValue)
        }.menuStyle(.borderedButton)
    }
}

//Arranges filter choice to a data format for use in groupby parameter in makeGenericData function
 func groupByClosure(for category: FilterButton.FilterOptions) -> (records) -> String {
    let clusterLookUp = Dictionary(uniqueKeysWithValues: sampleData.clusters.map { ($0.id, $0.region) })
    let modelLookUp = Dictionary(uniqueKeysWithValues: sampleData.models.map {($0.id, $0.displayName)})
    
    switch category {
        case .cluster : return {record in clusterLookUp[record.clusterId] ?? "Unknown"}
        case .query: return {record in record.queryType}
        case .model: return {record in modelLookUp[record.modelId] ?? "Unknown"}
        case .wow: return {_ in "WoW"}
        default: return {_ in "Total"}
    }

}

//Checklist: add protocol enviornment for data, switch filter options to enum type (Done), fix function/object title formats (Done), fix systemImage issue (done)
