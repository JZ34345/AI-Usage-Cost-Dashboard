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
    let data: [GenericSummary]
    let ylabel: String
    
        //MARK: Parameters
    init(data: [GenericSummary], ylabel: String) {
        self.data = data
        self.ylabel = ylabel
    }
    
    var stdDev: Double {
        return sqrt(appData.totalVariance)
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
                Chart {
                    ForEach(data) { item in
                        LineMark(
                            x: .value("Day", item.day),
                            y: .value(ylabel, item.cost / 100)
                        ).foregroundStyle(by: .value("Catagory", item.category))
                    }
                    
                    ForEach(data) { item in
                        let lower = item.cost - stdDev
                        let upper = item.cost + stdDev
                        
                        AreaMark(
                            x: .value("Day", item.day),
                            yStart: .value("Lower", lower),
                            yEnd: .value("Upper", upper)
                        ).foregroundStyle(.green.opacity(0.3))
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
                        //     AxisMarks(values: .stride(by: .day, count: tickStride)) { value in
                        //AxisGridLine()
                        //         AxisTick()
                        //if let date = value.as(Date.self) {
                        //   AxisValueLabel(anchor: .top) {
                        //        Text(date, format: .dateTime.month(.abbreviated).day())
                        //    }
                        //}
                    }
                //y-axis adjustments
                    .chartYAxisLabel(ylabel, position: .topTrailing)
                //chartYAxis {
                //    AxisMarks(values: .automatic(desiredCount: 10))
                //}
                    .frame(minHeight: 500)
                    .chartLegend(position: .top)
            }
            Spacer()
        }
    }
}
