//
//  Loading.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import XCTest
@testable import Buttery_Internship

//MARK: FileLoader Tests
//Tests whether a file loads in properly, dates are filtered propertly, and if they are ascessible
class FileLoaderTests: XCTestCase {
    
    //MARK: Tests
    func testLoadSucess() {
        let data = GraphDataSource(provider: BundleFileProvider(fileName: "sample-data"))
        XCTAssertNotNil(data.fileData, "File should load correctly")
        XCTAssertNil(data.dataError, "Error should be nil")
    }
    
    func testLoadFail() {
        struct BadScenario: FileProvider {
            func fetch() throws -> File {
                throw FileError.fileNotFound("Nil")
            }
        }
        
        let data = GraphDataSource(provider: BadScenario())
        XCTAssertNil(data.fileData, "File should not load correctly")
        XCTAssertNotNil(data.dataError, "Error should be displayed")
    }
    
    func testParsedDates() {
        let data = GraphDataSource(provider: BundleFileProvider(fileName: "sample-data"))
        XCTAssertFalse(data.records.isEmpty, "{Parsed dates should not be empty")
    }
    
    func testRecordsAccessible() {
        let data = GraphDataSource(provider: BundleFileProvider(fileName: "sample-data"))
        XCTAssertNotNil(data.records.first, "{Records should be accessible}")
    }
}

