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

        //MARK: Options
    //filter choices
     enum FilterOptions: String, CaseIterable {
        case total = "Total"
        case cluster = "Cluster"
        case model = "Model"
        case query = "Query Type"
        case wow = "WoW"
    }
    
        //MARK: UI Structure
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



//Checklist: add protocol enviornment for data
