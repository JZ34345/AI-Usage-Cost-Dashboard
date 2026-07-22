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
    @State private var showInfo = false
    
    init(description: String) {
        self.description = description
    }
    
    
    var body: some View {
        @Bindable var appData = appData
        Button {
           showInfo = true
        } label: {
            Image(systemName: "info.circle")
        }.frame(width: 15, height: 15, alignment: .center)
        .popover(isPresented: $showInfo) {
            VStack {
                Text("Description").font(.headline)
                
                Text(description)
            }
            .frame(width: 320, height: 150)
        }
    }
}
