//
//  MultiSelectSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct MultiSelectSummary {
    let topCategory: String
    let topCategorySpent: Double
    let topCategoryPct: Double
    let lowestCategory: String
    let lowestCategorySpent: Double
    let categoryCount: Int
    let mostVolatile: String

}
func makeMultiSelectSummary(from data: [GenericSummary]) -> MultiSelectSummary {
    let groupByCategory = Dictionary(grouping: data) {$0.category}
    let categorySums = groupByCategory.mapValues {items in items.reduce(0.0) {$0 + $1.cost}}
    
    let total = categorySums.values.reduce(0.0, +)
    let top = categorySums.max(by: {$0.value < $1.value})
    let low = categorySums.min(by: {$0.value < $1.value})
    
    let volatile = groupByCategory.mapValues { items -> Double in
        let costs = items.map(\.cost)
        let mean = costs.reduce(0.0, +) / Double(costs.count)
        let variance = costs.map {pow($0 - mean, 2)}.reduce(0.0, +) / Double(costs.count)
        return sqrt(variance)
    }
    let mostVolatile = volatile.max(by: {$0.value < $1.value})?.key ?? "-"

    return MultiSelectSummary(topCategory: top?.key ?? "-", topCategorySpent: top?.value ?? 0,
                              topCategoryPct: total > 0 ? ((top?.value ?? 0) / total) * 100 : 0 ,
                              lowestCategory: low?.key ?? "-", lowestCategorySpent: low?.value ?? 0,
                              categoryCount: categorySums.count, mostVolatile: mostVolatile)
}

