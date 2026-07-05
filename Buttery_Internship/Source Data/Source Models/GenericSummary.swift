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
    public let id = UUID()
    public let day: Date
    public let category: String
    public let cost: Double
}

