//
//  KPI Button.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
import Cocoa
import SwiftUI

struct KPICard: View {
    let title: String
    let value: Double?
    let format: String
    let label: String?
    
    init(title: String, value: Double?, format: String = "%.2f", label: String? = nil) {
        self.title = title
        self.value = value
        self.format = format
        self.label = label
    }
    
    var displayText: String {
        if let label = label {
            return label
        } else if let value = value {
            return String(format: format, value)
        } else {
            return "-"
        }
    }
    
    var valueColor: Color {
        guard let value = value else {
            return .primary
        }
        
        if value < 0 {
            return .green
        } else if value > 0 {
            return .red
        } else {
            return .primary
        }
    }
    
    var body: some View {
        VStack {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(displayText).font(.title2).fontWeight(.semibold).foregroundStyle(valueColor)
        }
        .padding()
        .frame(alignment: .leading)
        .background(Color(NSColor.controlBackgroundColor))
    }
}
