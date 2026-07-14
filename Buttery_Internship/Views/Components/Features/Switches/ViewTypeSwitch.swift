//
//  ModelTypeSwitch.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/13/26.
//
import Cocoa
import SwiftUI

struct ViewTypeSwitch: View {
    @Environment(AppData.self) private var appData
    
    enum ViewType: String, CaseIterable {
        case graph = "Graph"
        case table = "Table"
    }
    
    var body: some View {
        @Bindable var appData = appData
        VStack{
            Text("View")
            Picker("", selection: $appData.viewType) {
                ForEach(ViewType.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }.pickerStyle(.segmented)
                .tint(.green)
        }
    }
    
}
