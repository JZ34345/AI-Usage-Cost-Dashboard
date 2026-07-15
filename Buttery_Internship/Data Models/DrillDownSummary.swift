//
//  DrillDownSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct DrillDownSummary {
    let totalSpent: Double
    let nodeCount: Int
    let mostExpensiveNode: String
    let mostExpensiveNodeCost: Double
    let averageCostPerNode: Double
    let dominantCatagory: String
    let dominantCatagoryPct: Double

}
func makeDrillDownSummary(from data: [GenericSummary]) -> DrillDownSummary {
    let total = data.reduce(0.0) {$0 + $1.cost}
    
    let groupByCategory = Dictionary(grouping: data) { $0.category }
    let categorySums = groupByCategory.mapValues { $0.reduce(0.0) { $0 + $1.cost } }
    
    let top = categorySums.max(by: {$0.value < $1.value})
    let categoryCount = categorySums.count
    
    return DrillDownSummary(totalSpent: total, nodeCount: categoryCount, mostExpensiveNode: top?.key ?? "-",
                            mostExpensiveNodeCost: top?.value ?? 0,
                            averageCostPerNode: categoryCount > 0 ? total / Double(categoryCount) : 0,
                            dominantCatagory: top?.key ?? "-",
                            dominantCatagoryPct: total > 0 ? ((top?.value ?? 0) / total) * 100 : 0)
}




