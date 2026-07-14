//
//  Error.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import SwiftUI
//MARK: Error
//Error message UI structure
struct Error: View {
    let error: String?
    
    init(error: String?) {
        self.error = error
    }
    
        //MARK: UI Structure
    var body: some View {
        VStack() {
            Image(systemName: "xmark.circle")
                .font(.largeTitle)
                .foregroundColor(.red)
            if let error = error {
                Text(error).font(.headline)
            } else {
                Text("No data available")
                    .font(.headline)
            }
        }.frame(width: 650, height: 500)
    }
}
