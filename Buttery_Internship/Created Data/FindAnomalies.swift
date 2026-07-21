//
//  FindAnomalies.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/19/26.
//
import Cocoa
import SwiftUI

func findAnomalies(from data: [GenericSummary], threshold: Double = 2.0) -> [Anomaly] {
    guard data.count >= 3 else {return []}
    
    let byCatagory = Dictionary(grouping: data) {$0.category}
    var anomalies: [Anomaly] = []
    
    for (category, item) in byCatagory {
        let sorted = item.sorted {$0.day < $1.day}
        let costs = sorted.map(\.cost)
        
        let mean = costs.reduce(0.0, +) / Double(costs.count)
        let variance = costs.reduce(0.0) { $0 + pow($1 - mean, 2) } / Double(costs.count)
        let stdDev = sqrt(variance)
        
        guard stdDev > 0 else {continue}
        
        for item in sorted {
            let zScore = (item.cost - mean) / stdDev
            if abs(zScore) > threshold {
                anomalies.append(Anomaly(day: item.day, category: item.category, cost: item.cost, mean: mean, stdDev: stdDev,
                                         zScore: zScore, isHigh: zScore > 0, isWoW: false))
            }
        }
    }
    
    return anomalies.sorted {$0.day < $1.day}
}

func findWoWAnomalies(from data: [GenericSummary], threshold: Double = 2.0) -> [Anomaly] {
    guard data.count >= 3 else {return []}
    
    let byCatagory = Dictionary(grouping: data) {$0.category}
    var anomalies: [Anomaly] = []
    
    for (category, item) in byCatagory {
        let sorted = item.sorted {$0.day < $1.day}

        var deltas: [(day: Date, delta: Double)] = []
        for (index, item) in sorted.enumerated() {
            guard index > 0 else {continue}
            let previous = sorted[index - 1]
            let delta = item.cost - previous.cost
            deltas.append((day: item.day, delta: delta))
        }
        
        guard !deltas.isEmpty else {continue}
        
        let delta = deltas.map(\.delta)
        let mean = delta.reduce(0.0, +) / Double(delta.count)
        let variance = delta.reduce(0.0) { $0 + pow($1 - mean, 2) } / Double(delta.count)
        let stdDev = sqrt(variance)
        
        guard stdDev > 0 else {continue}
        
        for (day, delta) in deltas {
            let zScore = (delta - mean) / stdDev
            if abs(zScore) > threshold {
                let weekCost = sorted.first {$0.day == day}?.cost ?? 0
                anomalies.append(Anomaly(day: day, category: category, cost: weekCost, mean: mean, stdDev: stdDev, zScore: zScore,
                                         isHigh: zScore > 0, isWoW: true))
            }
        }
    }
    
    return anomalies.sorted {$0.day < $1.day}
}
