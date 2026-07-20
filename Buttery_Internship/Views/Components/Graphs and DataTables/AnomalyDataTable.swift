//
//  AnomalyDataTable.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/19/26.
//
import Cocoa
import SwiftUI

struct AnomalyDataTable: View {
    @Environment(AppData.self) private var appData
    
    let anomalies: [Anomaly]
    
    init(anomalies: [Anomaly]) {
        self.anomalies = anomalies
    }
    //MARK: UI Structure
    var body: some View {
        //If statement is for error message
        if appData.costType == .total {
            //MARK: Total Cost
            if appData.datePickerError != nil {
                Error(error: appData.datePickerError).frame(maxWidth: .infinity, maxHeight: 300)
            } else if anomalies.isEmpty {
                Error(error: nil).frame(maxWidth: .infinity, maxHeight: 300)
            //Continues if no errors
            } else {
                Table(anomalies) {
                    TableColumn("Day") { anomaly in
                        Text(anomaly.day, format: .dateTime.month(.abbreviated).day().year()).font(.title3)
                    }
                    TableColumn("Category", value: \.category)
                    TableColumn("Cost ($)") { anomaly in
                        Text(anomaly.cost / 100, format: .currency(code: "USD")).font(.title3)
                    }
                    TableColumn("Cost (€)") { anomaly in
                        Text((anomaly.cost / 100) * 0.88, format: .currency(code: "EUR")).font(.title3)
                    }
                    TableColumn("Raw Cost") { anomaly in
                        Text(String(format: "%.2f", anomaly.cost)).font(.title3)
                    }
                    TableColumn("Raw Mean") { anomaly in
                        Text(String(format: "%.2f", anomaly.mean)).font(.title3)
                    }
                    TableColumn("Raw Deviation") { anomaly in
                        Text(String(format: "%.2f", anomaly.stdDev)).font(.title3)
                            .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)

                    }
                    TableColumn("Z-Score") { anomaly in
                        Text(String(format: "%.2f", anomaly.zScore)).font(.title3)
                            .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)

                    }
                    TableColumn("Type") { anomaly in
                        Label(anomaly.isHigh ? "High" : "Low",
                              systemImage: anomaly.isHigh ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                        .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)

                    }
                }.frame(width: 680, height: 500)
            }
        } else {
            //MARK: Average Cost
            if appData.datePickerError != nil {
                Error(error: appData.datePickerError).frame(maxWidth: .infinity, maxHeight: 300)
            } else if anomalies.isEmpty {
                Error(error: nil).frame(maxWidth: .infinity, maxHeight: 300)
            //Continues if no errors
            } else {
                Table(anomalies) {
                    TableColumn("Day") { anomaly in
                        Text(anomaly.day, format: .dateTime.month(.abbreviated).day().year()).font(.title3)
                    }
                    TableColumn("Category", value: \.category)
                    TableColumn("Average Cost ($)") { anomaly in
                        Text(anomaly.cost / 100, format: .currency(code: "USD")).font(.title3)
                    }
                    TableColumn("Average Cost (€)") { anomaly in
                        Text((anomaly.cost / 100) * 0.88, format: .currency(code: "EUR")).font(.title3)
                    }
                    TableColumn("Average Raw Cost") { anomaly in
                        Text(String(format: "%.2f", anomaly.cost)).font(.title3)
                    }
                    TableColumn("Average Raw Mean") { anomaly in
                        Text(String(format: "%.2f", anomaly.mean)).font(.title3)
                    }
                    TableColumn("Average Raw Deviation") { anomaly in
                        Text(String(format: "%.2f", anomaly.stdDev)).font(.title3)
                            .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)
                    }
                    TableColumn("Average Z-Score") { anomaly in
                        Text(String(format: "%.", anomaly.zScore)).font(.title3)
                            .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)
                    }
                    TableColumn("Type") { anomaly in
                        Label(anomaly.isHigh ? "High" : "Low",
                              systemImage: anomaly.isHigh ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                        .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)
                    }
                }.frame(height: 500)
            }
        }
    }
}
