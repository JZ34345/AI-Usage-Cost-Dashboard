//
//  ValueTypeSwitch.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/7/26.
//
import Cocoa
import SwiftUI
import Charts

struct CostTypeSwitch: View {
    @Environment(AppData.self) private var appData
    
    enum CostType: String, CaseIterable {
        case total = "Total"
        case average = "Average"
    }
    
    var body: some View {
        @Bindable var appData = appData
        VStack{
            Text("Cost")
            Picker("", selection: $appData.costType) {
                ForEach(CostType.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                    
                }
            }.pickerStyle(.segmented)
                .tint(.green)
        }
    }
}
