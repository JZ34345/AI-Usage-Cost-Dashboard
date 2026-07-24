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
        let wow = anomalies.first?.isWoW
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
                    TableColumn(wow! ? "Week Cost ($)" : "Cost ($)") { anomaly in
                        Text(anomaly.cost / 100, format: .currency(code: "USD")).font(.title3)
                    }
                    TableColumn(wow! ? "Week Cost (€)" : "Cost (€)") { anomaly in
                        Text((anomaly.cost / 100) * 0.88, format: .currency(code: "EUR")).font(.title3)
                    }
                    TableColumn(wow! ? "Raw Week Cost" : "Raw Cost") { anomaly in
                        Text(String(format: "%.2f", anomaly.cost)).font(.title3)
                    }
                    TableColumn(wow! ? "Average Delta" : "Raw Mean") { anomaly in
                        Text(String(format: "%.2f", anomaly.mean)).font(.title3)
                    }
                    if wow! == false {
                        TableColumn("Raw Deviation") { anomaly in
                           Text(String(format: "%.2f", anomaly.stdDev)).font(.title3)
                               .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)

                       }
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
                }.frame(height: 500)
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
                    TableColumn(wow! ? "Average Week Cost ($)" : "Average Cost ($)") { anomaly in
                        Text(anomaly.cost / 100, format: .currency(code: "USD")).font(.title3)
                    }
                    TableColumn(wow! ? "Average Week Cost (€)" : "Average Cost (€)") { anomaly in
                        Text((anomaly.cost / 100) * 0.88, format: .currency(code: "EUR")).font(.title3)
                    }
                    TableColumn(wow! ? "Raw Average Week Cost" : "Raw Average Cost") { anomaly in
                        Text(String(format: "%.2f", anomaly.cost)).font(.title3)
                    }
                    TableColumn(wow! ? "Average Delta" : "Raw Average Mean") { anomaly in
                        Text(String(format: "%.2f", anomaly.mean)).font(.title3)
                    }
                    if wow! == false {
                        TableColumn("Raw Average Deviation") { anomaly in
                           Text(String(format: "%.2f", anomaly.stdDev)).font(.title3)
                               .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)

                       }
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
                }.frame(height: 500)
            }
        }
    }
}
