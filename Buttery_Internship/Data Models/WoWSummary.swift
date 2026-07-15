//
//  WoWSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct WoWSummary {
    let averageWeeklyDelta: Double
    let maxIncrease: Double
    let maxDecrease: Double
    let totalTrend: Double
    let weeksIncreasing: Int
    let weeksDecreasing: Int
}
func makeWoWSummary(from data: [GenericSummary]) -> WoWSummary {
    let delta = data.map { $0.cost }
    
    return WoWSummary(averageWeeklyDelta: delta.reduce(0, +) / Double(delta.count), maxIncrease: delta.max() ?? 0, maxDecrease: delta.min() ?? 0, totalTrend: (delta.last ?? 0) - (delta.first ?? 0), weeksIncreasing: delta.filter {$0 > 0}.count, weeksDecreasing:  delta.filter {$0 < 0}.count)
}
