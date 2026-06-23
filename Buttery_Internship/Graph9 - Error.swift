//
//  Graph8 - Error.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/20/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

let errorData = makeGenericGraph(metric: {$0.costCents}, dayLimit: 0)

let errorGraph = genericGraph(data: errorData, title: " ", ylabel: " ", isDelta: false)

let errorDataTable = genericDataTable(data: errorData, title: " ", category: " ", isDelta: false)
