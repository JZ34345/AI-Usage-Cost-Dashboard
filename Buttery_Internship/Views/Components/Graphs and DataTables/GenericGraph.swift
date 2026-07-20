//
//  GenericGraph.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import Cocoa
import Charts
import SwiftUI

//MARK: Generic Graph View maker
struct genericGraph: View {
    @Environment(AppData.self) private var appData
    
    let data: [GenericSummary]
    let anomaly: [Anomaly]?
    let ylabel: String
    let isDelta: Bool
    
    //MARK: Parameters
    init(data: [GenericSummary], anomaly: [Anomaly]?, ylabel: String, isDelta: Bool) {
        self.data = data
        self.anomaly = anomaly
        self.ylabel = ylabel
        self.isDelta = isDelta
    }
    
    var tickStride: Int {
        let dayCount = Set(data.map {$0.day}).count
        switch dayCount {
        case 0...8: return 1
        case 9...30: return 3
        case 31...40: return 4
        default: return max(1, dayCount / 6)
        }
    }
    
    var weekTickStride: Int {
        let weekCount = Set(data.map {$0.day}).count
        switch weekCount {
        case 0...8: return 1
        case 9...16: return 2
        case 17...26: return 2
        default: return max(1, weekCount / 6)
        }
    }
    
    var weekTicks: [Date] {
        let sorted = Array(Set(data.map { $0.day })).sorted()
        return sorted.enumerated().compactMap { index, date in
            if index % weekTickStride == 0 {
                date
            } else {
                nil
            }
        }
    }
    
    //MARK: Graph Marks
    @ChartContentBuilder
    func dataMarks() -> some ChartContent {
        ForEach(data) { item in
            LineMark(
                x: .value("date", item.day),
                y: .value(ylabel, item.cost / 100)
            ).foregroundStyle(by: .value("Catagory", item.category))
            
            //Special zero x-axis line for WoW delta
            if isDelta {
                RuleMark(y: .value("Zero", 0)).foregroundStyle(.gray)
            }
        }
    }
    
    //MARK: Anomaly Marks
    @ChartContentBuilder
    func anomalyMarks(anomalies: [Anomaly]) -> some ChartContent {
        ForEach(anomalies) { anomaly in
            PointMark(x: .value("Date", anomaly.day), y: .value(ylabel, anomaly.cost / 100))
                .foregroundStyle(anomaly.isHigh ? Color.red : Color.green)
            
            RuleMark(x: .value("Date", anomaly.day))
                .foregroundStyle(anomaly.isHigh ? .red.opacity(0.5) : .green.opacity(0.5))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 4]))
                .annotation(position: anomaly.isHigh ? .top : .bottom) {
                                Text(anomaly.isHigh ? "↑ High" : "↓ Low")
                                    .font(.caption2)
                                    .foregroundColor(anomaly.isHigh ? .red : .green)
                                    .padding(4)
                                    .background(.regularMaterial)
                                    .cornerRadius(4)
                            }
        }
    }
    
    
    
        //MARK: UI Structure
    var body: some View {
        VStack {
            // if statement for error message
            if appData.datePickerError != nil {
                Error(error: appData.datePickerError).frame(maxWidth: .infinity, maxHeight: 300)
            } else if data.isEmpty {
                Error(error: nil).frame(maxWidth: .infinity, maxHeight: 300)
                //Graph with no errors
            } else {
                Chart() {
                    dataMarks()
                    
                    //Show anomaly's when switched
                    if appData.anomalySwitch == .on {
                        anomalyMarks(anomalies: anomaly ?? [])
                    }
                }.onAppear {
                    appData.dataExport = data
                }.onChange(of: data) { _, new in
                    appData.dataExport = new
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black))
                //x-axis adjustments
                    .chartXAxisLabel("Date", alignment: .center)
                    .chartXAxis {
                        if isDelta && appData.dateFilter != .seven {
                            AxisMarks(values: weekTicks) { value in
                                AxisGridLine()
                                AxisTick()
                                if let date = value.as(Date.self) {
                                    AxisValueLabel(anchor: .top) {
                                        Text(date, format: .dateTime.month(.abbreviated).day())
                                    }
                                } else {
                                    AxisValueLabel()
                                }
                            }
                        } else {
                            AxisMarks(values: .stride(by: .day, count: tickStride)) { value in
                                AxisGridLine()
                                AxisTick()
                                if let date = value.as(Date.self) {
                                    AxisValueLabel(anchor: .top) {
                                        Text(date, format: .dateTime.month(.abbreviated).day())
                                    }
                                }
                            }
                        }
                    }
                //y-axis adjustments
                    .chartYAxisLabel(ylabel, position: .topTrailing)
                    .chartYAxis {
                        AxisMarks(values: .automatic(desiredCount: 10))
                    }
                    .frame(minHeight: 500)
                    .chartLegend(position: .top)
            }
        }
        Spacer()
    }
}
