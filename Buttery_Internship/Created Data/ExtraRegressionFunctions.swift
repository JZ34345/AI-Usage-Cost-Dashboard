//
//  ExtraRegressionFunctions.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/18/26.
//
import Cocoa
import SwiftUI

func smoothData(_ data: [GenericSummary], window: Int = 7) -> [GenericSummary] {
    let sorted = data.sorted {$0.day < $1.day}
    return sorted.enumerated().map { index, item in
        let start = max(0, index - window + 1)
        let windowItems = Array(sorted[start...index])
        let avg = windowItems.reduce(0.0) {$0 + $1.cost} / Double(windowItems.count)
        
        return GenericSummary(day: item.day, category: item.category, cost: avg)
    }
}

func removeOutliers(_ points: [(x: Double, y: Double)]) -> [(x: Double, y: Double)] {
    let ys = points.map(\.y)
    let mean = ys.reduce(0.0, +) / Double(ys.count)
    let variance = ys.reduce(0.0) {$0 + pow($1 - mean, 2)} / Double(ys.count)
    let stdDev = sqrt(variance)
    
    return points.filter {abs($0.y - mean) <= 2 * stdDev}
}
