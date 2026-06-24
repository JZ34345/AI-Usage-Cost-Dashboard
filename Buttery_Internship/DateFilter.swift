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
    @Binding private var showDateFilter: DataFilterOptions
    @Binding private var startDate: String
    @Binding private var endDate: String
    
    @State private var showDatePicker = false
    
    //date filter selection, start date, and end date parameters
     init(showDateFilter: Binding<DataFilterOptions>, startDate: Binding<String>, endDate: Binding<String>) {
        self._showDateFilter = showDateFilter
        self._startDate = startDate
        self._endDate = endDate
    }
    
    //date filter options
     enum DataFilterOptions: String, CaseIterable {
        case seven = "7 Days"
        case thirty = "30 Days"
        case ninety = "90 Days"
        case custom = "Custom"
    }
    
     var body: some View {
        //UI appearance for date filter
        Menu {
            ForEach(DataFilterOptions.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    showDateFilter = option
                    
                    if option == .custom {
                        showDatePicker = true
                    }
                }
                
            }
        } label: {
            Text(showDateFilter.rawValue)
        }.menuStyle(.borderedButton)
        //Display for custom input
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    Text("Custom Date Range").font(.headline)
                    
                    TextField("(yyyy-MM-dd)", text: $startDate)
                    TextField("(yyyy-MM-dd)", text: $endDate)
                    
                    Button("Apply") {
                        showDatePicker = false
                    }
                }.padding().frame(width: 300)
            }
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

//Filter structure
 func dateRangeFilter(option: DateFilterButton.DataFilterOptions, start: String, end: String) -> (records) -> Bool {
    let formatter = ISO8601DateFormatter()
    let calendar = Calendar.current
    let mostRecentDate = sampleData.records.compactMap { formatter.date(from: $0.day) }.max() ?? Date()
    
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
