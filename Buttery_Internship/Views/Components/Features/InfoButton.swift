//
//  InfoButton.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/12/26.
//
import Cocoa
import SwiftUI

struct InfoButton: View {
    @Environment(AppData.self) private var appData
    
    var description: String
    
    init(description: String) {
        self.description = description
    }
    
    
    var body: some View {
        @Bindable var appData = appData
        Button {
            appData.showInfo = true
        } label: {
            Image(systemName: "info.circle")
        }
        .popover(isPresented: $appData.showInfo) {
            VStack {
                Text("Description").font(.headline)
                
                Text(description)
            }
            .padding()
            .frame(width: 300, height: 150)
        }
    }
}
