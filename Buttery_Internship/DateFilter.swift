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
    
    public init(showDateFilter: Binding<String>) {
        self._showDateFilter = showDateFilter
    }
    
    public let FilterOptions = ["7 Days", "30 Days", "90 Days", "Custom"]
    public var body: some View {
        Menu {
            ForEach(FilterOptions, id: \.self) { option in
                Button(option) {
                    showDateFilter = option
                }
                
            }
        } label: {
            Label(showDateFilter, systemImage: "⏎")
        }.menuStyle(.borderedButton)
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
