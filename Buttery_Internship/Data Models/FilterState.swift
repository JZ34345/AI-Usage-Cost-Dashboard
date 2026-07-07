//
//  FilterState.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/6/26.
//
import Cocoa
import SwiftUI

struct FilterState: Equatable {
    let mainFilter: FilterButton.FilterOptions
    let dateFilter: DateFilterButton.DataFilterOptions
    let startDate: String
    let endDate: String
    let drillCluster: DrillDownButton.DrillDownClusterOptions
    let drillNode: DrillNodeButton.DrillDownNodeOptions
}
