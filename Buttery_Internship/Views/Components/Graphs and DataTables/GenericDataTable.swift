//
//  GenericDataTable.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/4/26.
//
import Cocoa
import Charts
import SwiftUI

//MARK: Generic DataTable Function
struct genericDataTable: View {
    let data: [GenericSummary]
    let title: String
    let category: String
    let isDelta: Bool
    let isAverage: Bool
    
    init(data: [GenericSummary], title: String, category: String, isDelta: Bool, isAverage: Bool) {
        self.data = data
        self.title = title
        self.category = category
        self.isDelta = isDelta
        self.isAverage = isAverage
    }
    
    //Determines whether a catagory for datatype exists and is not default 'total'
    var hasCatagory: Bool {
        data.contains{!$0.category.isEmpty && $0.category != "Total"}
    }
            //MARK: UI Structure
    var body: some View {
        VStack {
            Text(title).font(.headline)
            //If statement is for error message
            if data.isEmpty {
                Error().frame(maxWidth: .infinity, maxHeight: 300)
            //Continues if no errors
            } else {
                    //MARK: Total Cost
                if isAverage == false {
                    //This is for tables with groupby aggregation
                    if hasCatagory {
                        //Datatables for non WoW delta
                        if isDelta == false {
                            Table(data) {
                                TableColumn("Id") { item in Text("\(item.id)")}
                                TableColumn("Day") { item in
                                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                                }
                                TableColumn(category) {item in Text("\(item.category)")}
                                TableColumn("Cost (Cents)") { item in
                                    Text(String(format: "%.2f", item.cost))
                                }
                            }
                            .frame(width: 600, height: 500)
                        }
                        //Datatable for WoW delta
                        else {
                            Table(data) {
                                TableColumn("Id") { item in Text("\(item.id)")}
                                TableColumn("Day") { item in
                                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                                }
                                TableColumn(category) {item in Text("\(item.category)")}
                                TableColumn("Delta (Cents)") { item in
                                    Text(String(format: "%.2f", item.cost))
                                }
                            }
                            .frame(width: 600, height: 500)
                        }
                    //This is for tables with no grouping, only one datatype of node, model, cluster, etc
                    } else {
                        Table(data) {
                            TableColumn("Id") { item in Text("\(item.id)")}
                            TableColumn("Day") { item in
                                Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                            }
                            TableColumn("Cost (Cents)") { item in
                                Text(String(format: "%.2f", item.cost))
                            }
                        }
                        .frame(width: 600, height: 500)
                    }
                    //MARK: Average Cost
                } else {
                    //This is for tables with groupby aggregation
                    if hasCatagory {
                        //Datatables for non WoW delta
                        if isDelta == false {
                            Table(data) {
                                TableColumn("Id") { item in Text("\(item.id)")}
                                TableColumn("Day") { item in
                                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                                }
                                TableColumn(category) {item in Text("\(item.category)")}
                                TableColumn("Average Cost (Cents)") { item in
                                    Text(String(format: "%.2f", item.cost))
                                }
                            }
                            .frame(width: 600, height: 500)
                        }
                        //Datatable for WoW delta
                        else {
                            Table(data) {
                                TableColumn("Id") { item in Text("\(item.id)")}
                                TableColumn("Day") { item in
                                    Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                                }
                                TableColumn(category) {item in Text("\(item.category)")}
                                TableColumn("Average Delta (Cents)") { item in
                                    Text(String(format: "%.2f", item.cost))
                                }
                            }
                            .frame(width: 600, height: 500)
                        }
                    //This is for tables with no grouping, only one datatype of node, model, cluster, etc
                    } else {
                        Table(data) {
                            TableColumn("Id") { item in Text("\(item.id)")}
                            TableColumn("Day") { item in
                                Text(item.day, format: .dateTime.month(.abbreviated).day().year())
                            }
                            TableColumn("Average Cost (Cents)") { item in
                                Text(String(format: "%.2f", item.cost))
                            }
                        }
                        .frame(width: 600, height: 500)
                    }
                }
            }
        }
    }
    
}

