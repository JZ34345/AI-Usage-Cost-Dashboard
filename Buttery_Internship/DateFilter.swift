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

//MARK: Date filter in progress (Work on custom input)
public struct DateFilterButton: View {
    @Binding private var showDateFilter: String
    @Binding private var startDate: String
    @Binding private var endDate: String
    
    @State private var showDatePicker = false
    
    public init(showDateFilter: Binding<String>, startDate: Binding<String>, endDate: Binding<String>) {
        self._showDateFilter = showDateFilter
        self._startDate = startDate
        self._endDate = endDate
    }
    
    public let FilterOptions = ["7 Days", "30 Days", "90 Days", "Custom"]
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showDateFilter = option
                    
                    if option == "Custom" {
                        showDatePicker = true
                    }
                }
                
            }
        } label: {
            Label(showDateFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
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

public func dateByClosure(for period: String) -> Int {
    switch period {
        case "7 Days": return 7
        case "30 Days": return 30
        case "90 Days": return 90
        default: return 30
    }
}

public func dateRangeFilter(option: String, start: String, end: String) -> (records) -> Bool {
    let formatter = ISO8601DateFormatter()
    let calendar = Calendar.current
    let mostRecentDate = sampleData.records.compactMap { formatter.date(from: $0.day) }.max() ?? Date()
    
    switch option {
    case "7 Days":
        let cutoff = calendar.date(byAdding: .day, value: -7, to: mostRecentDate)!
        return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
    case "30 Days":
        let cutoff = calendar.date(byAdding: .day, value: -30, to: mostRecentDate)!
        return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
    case "90 Days":
        let cutoff = calendar.date(byAdding: .day, value: -90, to: mostRecentDate)!
        return {record in (formatter.date(from: record.day) ?? .distantPast) >= cutoff}
    case "Custom":
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
    default:
        return {_ in true}

    }
    
}
