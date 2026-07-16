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

    let maxSelect = 2
     
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
             Text("Multi-Select").fontWeight(.semibold)
             Menu {
                 Button("Select All") {
                     appData.multiSelectFilter = Set(MultiSelectFilterButton.FilterOptions.allCases)
                 }.fontWeight(.medium)
                 
                 Button("Deselect All") {
                     appData.multiSelectFilter = []
                 }.fontWeight(.medium)
                 
                 Divider()
                 
                 ForEach(FilterOptions.allCases, id: \.self) { option in
                     let yesContains = appData.multiSelectFilter.contains(option)
                     let atMax = appData.multiSelectFilter.count >= maxSelect && !yesContains
                     
                     Button {
                         if yesContains && appData.multiSelectFilter.count > 1 {
                                 appData.multiSelectFilter.remove(option)
                         } else if !atMax{
                             appData.multiSelectFilter.insert(option)
                         }
                     } label: {
                         Label(option.rawValue,
                               systemImage: yesContains ? "checkmark" : "")
                     }
                     .disabled(atMax)
                 }
                 
                 if appData.multiSelectFilter.count >= maxSelect {
                     Divider()
                     Text("\(maxSelect) is the max number of selections")
                         .font(.caption)
                         .foregroundStyle(.secondary)
                 }
                 
             } label: {
                 Label("", systemImage: "line.3.horizontal.decrease")
             }.menuStyle(.borderedButton)
                 .tint(.red)
         }
    }
}
