//
//  DateFilter.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/19/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Date filter
 struct DateFilterButton: View {
     @Environment(AppData.self) private var appData
     
    //date filter options
     enum DataFilterOptions: String, CaseIterable {
        case seven = "7 Days"
        case thirty = "30 Days"
        case ninety = "90 Days"
        case custom = "Custom"
    }
    
     var body: some View {
        @Bindable var appBindData = appData
         
         
        //UI appearance for date filter
        Menu {
            ForEach(DataFilterOptions.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    appData.dateFilter = option
                    
                    if option == .custom {
                        appData.datePicker = true
                    }
                }
                
            }
        } label: {
            Text(appData.dateFilter.rawValue)
        }.menuStyle(.borderedButton)
         
        //Display for custom input
             .sheet(isPresented: $appBindData.datePicker) {
                VStack {
                    Text("Custom Date Range").font(.headline)
                    
                    TextField("(yyyy-MM-dd)", text: $appBindData.startDate)
                    TextField("(yyyy-MM-dd)", text: $appBindData.endDate)
                    
                    Button("Apply") {
                        appData.datePicker = false
                    }
                }.padding().frame(width: 300)
            }
    }
}
