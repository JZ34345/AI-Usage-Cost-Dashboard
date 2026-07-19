//
//  View - MLSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
import Cocoa
import SwiftUI

struct RegressionSummaryView: View {
    @Environment(AppData.self) private var appData
    let data: [GenericSummary]
    
    init(data: [GenericSummary]) {
        self.data = data
    }
    
    var body: some View {
        if appData.rSquared < 0.5 {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                Text("Low R² (\(String(format: "%.2f", appData.rSquared))) — forecast may not be reliable for this date range")
                    .font(.caption)
                    .foregroundColor(.secondary)
                InfoButton(description: "Since the R^2 is too low, the forecast switches to using the mean of the y axis points instead of the regression line that is trending to zero.")
            }
            .padding(.horizontal)
        } else {
            HStack {
                KPICard(title: "Cost Trend", value: nil,
                        label: appData.slope > 0.5 ? "↑ Increasing" :
                                appData.slope < -0.5 ? "↓ Decreasing" : "→ Stable"
                )
                KPICard(title: "R^2 Score", value: appData.rSquared)
                InfoButton(description: "R^2 score refers to how reliable and credible the predictions on the graph are. A score of 0.9 - 1.0 is very reliable, 0.7 - 0.9 is relatively reliable, 0.5 - 0.7 is uncertain, or a rough estimate, and 0.5 or less is unreliable and can't be predicted with linear regression.")
            }
        }
    }
}

