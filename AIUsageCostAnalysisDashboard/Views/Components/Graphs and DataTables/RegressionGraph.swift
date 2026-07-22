//
//  MLGraphs.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
import Cocoa
import SwiftUI
import Charts

struct MLGraphs: View {
    @Environment(AppData.self) private var appData
    let realData: [GenericSummary]
    let regressionData: [GenericSummary]
    let ylabel: String
    
        //MARK: Parameters
    init(realData: [GenericSummary], regressionData: [GenericSummary], ylabel: String) {
        self.realData = realData
        self.regressionData = regressionData
        self.ylabel = ylabel
    }
    
    var tickStride: Int {
        let dayCount = Set((realData + regressionData).map {$0.day}).count
        switch dayCount {
        case 0...8: return 1
        case 9...30: return 3
        case 31...40: return 4
        default: return max(1, dayCount / 6)
        }
    }
    
    var stdDev: Double {
        return sqrt(appData.std)
    }
    
    @ChartContentBuilder
    func realDataMarks() -> some ChartContent {
        ForEach(realData) { item in
            LineMark(
                x: .value("Day", item.day),
                y: .value(ylabel, item.cost / 100)
            ).foregroundStyle(.blue)
        }
    }
    
    @ChartContentBuilder
    func regressionDataMarks() -> some ChartContent {
        ForEach(regressionData) { item in
            let dollarCost = item.cost / 100
            
            LineMark(
                x: .value("Day", item.day),
                y: .value(ylabel, dollarCost)
            ).foregroundStyle(.orange)
        }
    }
    
    @ChartContentBuilder
    func regressionBandMarks() -> some ChartContent {
        ForEach(regressionData) { item in
            let lower = (item.cost - stdDev) / 100
            let upper = (item.cost + stdDev) / 100
            
            AreaMark(
                x: .value("Day", item.day),
                yStart: .value("Lower", lower ),
                yEnd: .value("Upper", upper )
            ).foregroundStyle(.green.opacity(0.3))
        }
    }
    
    
        //MARK: UI Structure
    var body: some View {
        VStack {
            // if statement for error message
            if appData.datePickerError != nil {
                Error(error: appData.datePickerError).frame(maxWidth: .infinity, maxHeight: 300)
            } else if realData.isEmpty || regressionData.isEmpty {
                Error(error: nil).frame(maxWidth: .infinity, maxHeight: 300)
                //Graph with no errors
            } else {
                Chart {
                    realDataMarks()
                    regressionDataMarks()
                    regressionBandMarks()
                }.onAppear {
                    appData.dataExport = regressionData
                }.onChange(of: regressionData) { _, new in
                    appData.dataExport = new
                }.padding()
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black))
                //x-axis adjustments
                    .chartXAxisLabel("Date", alignment: .center)
                    .chartXAxis {
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
                    //y-axis adjustments
                        .chartYAxisLabel(ylabel, position: .topTrailing)
                    .chartYAxis {
                        AxisMarks(values: .automatic(desiredCount: 10))
                    }
                    .frame(minHeight: 500)
                    .chartLegend(position: .top)
                Spacer()
            }
        }
    }
}
