//
//  Anomaly.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/19/26.
//
import Cocoa
import SwiftUI

struct Anomaly: Identifiable {
    let id = UUID()
    let day: Date
    let category: String
    let cost: Double
    let mean: Double
    let stdDev: Double
    let zScore: Double
    let isHigh: Bool
    let isWoW: Bool
    
    var deviation: Double {cost - mean}
    var deviationPct: Double {mean == 0 ? 0 : (deviation / mean) * 100}
}
