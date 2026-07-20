//
//  AnomalySwitch.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/19/26.
//
import Cocoa
import SwiftUI

struct AnomalySwitch: View {
    @Environment(AppData.self) private var appData
    
    enum anomalyCase: String, CaseIterable {
        case on = "On"
        case off = "Off"
    }
    
    var body: some View {
        @Bindable var appData = appData
        VStack{
            Text("Anomaly").fontWeight(.semibold).font(.headline)
            Picker("", selection: $appData.anomalySwitch) {
                ForEach(anomalyCase.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                    
                }
            }.pickerStyle(.segmented)
                .tint(.cyan)
        }
    }
}

