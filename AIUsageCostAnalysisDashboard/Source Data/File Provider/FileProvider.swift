//
//  FileProvider.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/30/26.
//
//FileProvider protocol for file name, extension, and display name
import Cocoa
import SwiftUI

//Provider function is just to give a file
protocol FileProvider: Sendable {
   func fetch() throws -> File
}

//Produces different types of errors based on the situation
enum FileError: LocalizedError {
        case fileNotFound(String)
        case couldNotLoadData(String)
        case couldNotDecode(String)
        
    //The description of the error occuring
        var errorDescription: String? {
            switch self {
            case .fileNotFound(let name): return "Error: couldn't find file \(name).json"
            case .couldNotLoadData(let name): return "Error: failed to load file \(name).json"
            case .couldNotDecode(let name): return "Failed to decode file \(name).json"
            }
        }
}
