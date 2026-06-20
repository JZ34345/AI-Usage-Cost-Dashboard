//
//  CSVexport.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts
import UniformTypeIdentifiers
import AppKit

//MARK: CSV export in progress
public struct CSVExport: View {
    let data: [GenericSummary]
    
    public init(data: [GenericSummary]) {
        self.data = data
    }
    
    private func exportCSV() {
        var csv = "Day,Category,Cost\n"
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        
        for item in data {
            let day = dataFormatter.string(from: item.day)
            csv += "\(day),\(item.category),\(item.cost)\n"
        }
        
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.allowedContentTypes = [.commaSeparatedText]
            panel.nameFieldStringValue = "tableExport.csv"
            
            panel.begin { response in
                if  response == .OK, let url = panel.url {
                    do {
                        try csv.write(to: url, atomically: true, encoding: .utf8)
                        print("Export to \(url).")
                    } catch {
                        print("Export Failed: \(error)")
                    }
                }
            }
        }
    }
    
    public var body: some View {
        Button(action: {exportCSV()}) {
            Text("Export File").padding()
        }
    }
    
}


