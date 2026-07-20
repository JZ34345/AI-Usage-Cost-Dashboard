//
//  View - AnomalySummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/19/26.
//
import Cocoa
import SwiftUI

struct AnomalySummaryView: View {
    @Environment(AppData.self) private var appData
    
    let anomalies: [Anomaly]
    
    init(anomalies: [Anomaly]) {
        self.anomalies = anomalies
    }
    
    var body: some View {
        @Bindable var appData = appData

        VStack {
            VStack {
                Text("Anomalies Detected").font(.title3)
                Text("\(anomalies.count) flagged").font(.caption).foregroundStyle(.secondary)
            }
            HStack {
                Stepper(
                    "Threshold: \(String(format: "%.1f", appData.anomalyThreshold))", value: $appData.anomalyThreshold,
                    in: 0.0...3.0, step: 0.5
                )
            }.frame(width: 200)
            
            if anomalies.isEmpty {
                Text("No anomalies detected at \(String(format: "%.1f", appData.anomalyThreshold))")
                    .foregroundStyle(.secondary).padding()
            } else {
                HStack {
                    KPICard(title: "High Cost Days", value: nil, label: "\(anomalies.filter(\.isHigh).count)")
                    KPICard(title: "Low Cost Days", value: nil, label: "\(anomalies.filter {!$0.isHigh}.count)")
                    KPICard(title: "Largest Spike", value: anomalies.filter(\.isHigh).map(\.deviationPct).max(),
                            format: "%.1f%%")
                    KPICard(title: "Largest Drop", value: anomalies.filter {!$0.isHigh}.map(\.deviationPct).min(), format: "%.1f%%")
                }.padding(.horizontal)
            }
        }.padding(.vertical)
    }
}

