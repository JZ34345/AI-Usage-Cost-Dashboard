//
//  Error.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import SwiftUI

//Error message UI structure
struct Error: View {
    var body: some View {
        VStack() {
            Image(systemName: "xmark.circle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("No data available")
                .font(.headline)
        }.frame(width: 650, height: 500)
    }
}
