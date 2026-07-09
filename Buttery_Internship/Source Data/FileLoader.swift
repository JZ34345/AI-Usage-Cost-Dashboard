//
//  GraphData.swift
//  
//
//  Created by Jason Zhang on 6/16/26.
//
import Cocoa
import SwiftUI

//MARK: Read JSON File
// add a provider to the loadFile to differenciate between test and product information.
@Observable class GraphDataSource {
    private(set) var fileData: File?
    private(set) var dataError: String?
    private(set) var cachedDates: [String: Date] = [:]
    
    init(provider: any FileProvider ) {
        do {
            //Puts provider into a variable
            let file = try provider.fetch()
            
            //fileData class variable stores information of file variable
            self.fileData = file
            
            //Process dates from decoded file data
            let formatter = ISO8601DateFormatter()
            let uniqueDays = Set(file.records.map { $0.day })
            
            //Dates from decoded file cached for quicker loading formatted to unique days.
            self.cachedDates = Dictionary(
                uniqueKeysWithValues: uniqueDays.map {($0, formatter.date(from: $0) ?? Date())})            
        }
        //Gives error if an issue occurs
        catch let providerError {
            self.dataError = providerError.localizedDescription
        }
    }
    //Variables representing the different asscessible sections of the file data.
    var records: [records] {fileData?.records ?? []}
    var clusters: [clusters] {fileData?.clusters ?? []}
    var nodes: [nodes] {fileData?.nodes ?? []}
    var models: [models] {fileData?.models ?? []}
}
