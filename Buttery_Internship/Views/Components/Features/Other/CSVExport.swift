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

//MARK: CSV Export
struct CSVExport: View {
    @Environment(AppData.self) private var appData
    
        //MARK: Export Function
    func exportCSV() {
        let data = appData.dataExport
        
        //CSV variable includes titles
        var csv = "Day,Category,Cost\n"
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        
        //Writes information in csv file for each row entry in data
        for item in data {
            let day = dataFormatter.string(from: item.day)
            csv += "\(day),\(item.category),\(item.cost)\n"
        }
        
        //Creates the panel for selecting location, name, and upload status of csv file
        DispatchQueue.main.async {
            let panel = NSSavePanel()
            panel.allowedContentTypes = [.commaSeparatedText]
            panel.nameFieldStringValue = "tableExport.csv"
            
            panel.begin { response in
                if  response == .OK, let url = panel.url {
                    do {
                        //sucessful upload
                        try csv.write(to: url, atomically: true, encoding: .utf8)
                        print("Export to \(url).")
                    } catch {
                        //error message for unsucessful upload
                        print("Export Failed: \(error)")
                    }
                }
            }
        }
    }
        //MARK: UI Structure
    //Export button UI structure
    var body: some View {
        //Button for csv export in UI
        Button(action: {exportCSV()}) {
            Text("\(Image(systemName: "square.and.arrow.up"))")
        }
    }
    
}


