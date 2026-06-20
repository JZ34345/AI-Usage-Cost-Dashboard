//
//  CSVexport.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: CSV export in progress
public struct CSVExport: View {
    public init() {}
    public var body: some View {
        Button(action: {print("File exported!")}) {
            Text("Export File").padding()
        }
    }
    
}
