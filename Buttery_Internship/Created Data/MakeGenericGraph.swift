//
//  GenericGraph.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/18/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Generic aggregation function
func makeGenericGraph(record: [records], selectedDates: [String: Date], filter: (records) -> Bool = {_ in true},
                      groupBy category: (records) -> String = { _ in "Total"}, metric: @escaping (records) -> Double,
                      dayLimit: Int, applyDayLimit: Bool = true, groupWeek: Bool = false, delta: Bool = false)
-> [GenericSummary] {
    
    var calendar = Calendar.current
    calendar.timeZone = TimeZone(identifier: "UTC")!
    
    struct GroupKey: Hashable {
        let date: Date
        let category: String
    }
    
    //apply filters
    let filterRecords = record.filter(filter)
    
    //grouping by a datatype
    let grouped = Dictionary(grouping: filterRecords) { record -> GroupKey in
        let date = selectedDates[record.day] ?? Date()
        let week: Date
        if groupWeek {
            week = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
        } else {
            week = calendar.startOfDay(for: date)
        }
        
        return GroupKey(date: week, category: category(record))
    }
    
    //aggregation by metric parameter input
    let summed = grouped.map {key, group -> GenericSummary in
        let total  = group.reduce(0.0) {$0 + metric($1)}
        return GenericSummary(day: key.date, category: key.category, cost: total)
    }
    
    //data sorted by ascending dates
    var final = summed.sorted {$0.day < $1.day}
    
    //apply limits to dates for data for 7, 30, 90 days, or custom
    if applyDayLimit {
        let uniqueDays = Set(summed.map { $0.day }).sorted().suffix(dayLimit)
        let dayLimitSet = Set(uniqueDays)
        
        final = final.filter{dayLimitSet.contains($0.day)}
    }
    
    //special functionality for WoW delta data creation
    if delta {
        let categories = Dictionary(grouping: final) {$0.category}
        var deltaResult: [GenericSummary] = []
        
        for (category, items) in categories {
            let sorted = items.sorted {$0.day < $1.day}
            for (index, item) in sorted.enumerated() {
                let previous = index > 0 ? sorted[index - 1].cost : item.cost
                let delta = item.cost - previous
                deltaResult.append(GenericSummary(day: item.day, category: category, cost: delta))
            }
        }
        final = deltaResult.sorted {$0.day < $1.day}
    }
    
    return final
}
