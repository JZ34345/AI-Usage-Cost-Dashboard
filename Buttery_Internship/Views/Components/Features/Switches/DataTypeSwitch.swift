//
//  DataTypeSwitch.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/7/26.
//
import Cocoa
import SwiftUI
import Charts

struct DataTypeSwitch: View {
    @Environment(AppData.self) private var appData
    
    enum DataType: String, CaseIterable {
        case total = "Total"
        case wow = "WoW"
    }
    
    var body: some View {
        @Bindable var appData = appData
        VStack {
            Text("Data").fontWeight(.semibold).font(.headline)
            Picker("", selection: $appData.dataType) {
                ForEach(DataType.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }.pickerStyle(.segmented)
                .tint(.green)
            
        }.padding(.horizontal)
    }
}
