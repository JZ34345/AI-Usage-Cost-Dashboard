//
//  FileProvider.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/30/26.
//
//FileProvider protocol for file name, extension, and display name
protocol FileProvider {
    var fileName: String { get }
    var fileExtension: String { get }
    var displayName: String { get }
}

//MARK: FileCases enum
//Enum follows format of FileProvider protocol. Cases are split between sampleData structure and potentially other files.
//(Placeholder used to replace other potential files)

enum FileCases: FileProvider {
    case sampleData
    case other
    
    var fileName: String {
        switch self {
        case .sampleData: return "sample-data"
        case .other: return "Placeholder"
        }
    }
    
    var fileExtension: String {"json"}
    
    var displayName: String {
        switch self {
        case .sampleData: return "Sample Data"
        case .other: return "Placeholder"
        }
    }
    
}
