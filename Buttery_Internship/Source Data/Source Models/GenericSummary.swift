//
//  GenericSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import Cocoa
import SwiftUI

//MARK: Generic Data Model
struct GenericSummary: Identifiable {
    let id = UUID()
    let day: Date
    let category: String
    let cost: Double
}

