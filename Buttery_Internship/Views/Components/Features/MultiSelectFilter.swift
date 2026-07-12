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
//Limit to only 2 filter options
 struct MultiSelectFilterButton: View {
    //variable for what current filter choice is
    @Environment(AppData.self) private var appData

    //MARK: Options
    //filter choices
     enum FilterOptions: String, CaseIterable {
        case total = "Total"
        case cluster = "Cluster"
        case model = "Model"
        case query = "Query Type"
    }
     
     var label: String {
         switch appData.multiSelectFilter.count {
         case 0: return "None"
         case 1: return appData.multiSelectFilter.first!.rawValue
         default: return appData.multiSelectFilter.map {$0.rawValue}.sorted().joined(separator: ", ")
         
         }
     }
    
    //MARK: UI Structure
    var body: some View {
         VStack {
             Text("Multi-Select")
             Menu {
                 Button("Select All") {
                     appData.multiSelectFilter = Set(MultiSelectFilterButton.FilterOptions.allCases)
                 }
                 
                 Button("Deselect All") {
                     appData.multiSelectFilter = []
                 }
                 
                 Divider()
                 
                 ForEach(FilterOptions.allCases, id: \.self) { option in
                     Button {
                         if appData.multiSelectFilter.contains(option) && appData.multiSelectFilter.count > 1 {
                                 appData.multiSelectFilter.remove(option)
                         } else {
                             appData.multiSelectFilter.insert(option)
                         }
                     } label: {
                         Label(option.rawValue,
                               systemImage: appData.multiSelectFilter.contains(option) ? "checkmark" : "")
                     }
                     
                 }
             } label: {
                 Label("", systemImage: "line.3.horizontal.decrease")
             }.menuStyle(.borderedButton)
                 .tint(.red)
         }
    }
}
