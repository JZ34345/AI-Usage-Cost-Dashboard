//
//  Untitled.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import Cocoa
import SwiftUI

//MARK: Main Bundle Provider
//Provider used for any file name inputted (currently hardcoded to json but can be more flexible)
struct BundleFileProvider: FileProvider {
    let fileName: String
    
    func fetch() throws -> File {
        //Finds the file name based on information given and stores in a constant
        guard let url = Bundle.main.url(forResource: fileName,
                                        withExtension: "json")
        else {
            throw FileError.fileNotFound(fileName)
        }
        
        //Produces a constant of the data (undecoded) contained in url constant
        guard let data = try? Data(contentsOf: url) else {
            throw FileError.couldNotDecode(fileName)
        }
        
        let decoder = JSONDecoder()
        //decode data constant of JSON file into File struct structure
        do {
            let decoded = try decoder.decode(File.self, from: data)
            return decoded
            
        } catch {
            throw FileError.couldNotLoadData(fileName)
        }
    }
}

//MARK: Test Provider
//Provider used for tests (file structure given in the test file)
struct TestFileProvider: FileProvider {
    let mockFile: File
    
    func fetch() throws -> File {
        return mockFile
    }
}

//MARK: Error Provider
//Provider that mimicks a bad file to be used for error testing
struct FailFileProvider: FileProvider {
    func fetch() throws -> File {
        throw FileError.fileNotFound("testFail")
    }
}
