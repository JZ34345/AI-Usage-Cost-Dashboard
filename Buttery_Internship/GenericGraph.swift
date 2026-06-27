//
//  GenericGraph.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 6/18/26.
//
import Cocoa
import SwiftUI
import Charts
import SwiftData

//MARK: Generic Data Structure
struct GenericSummary: Identifiable {
    public let id = UUID()
    public let day: Date
    public let category: String
    public let cost: Double
}


//MARK: Generic aggregation function
func makeGenericGraph(
    record: [records],
    filter: (records) -> Bool = {_ in true},
    groupBy category: (records) -> String = { _ in "Total"},
    metric: @escaping (records) -> Double,
    dayLimit: Int,
    applyDayLimit: Bool = true,
    groupWeek: Bool = false,
    delta: Bool = false
) -> [GenericSummary] {

    //formatter for Date datatype
    let formatter = ISO8601DateFormatter()
    
    struct GroupKey: Hashable {
        let day: String
        let category: String
    }
    
    //apply filters
    let filterRecords = record.filter(filter)
    
    //grouping by a datatype
    let grouped = Dictionary(grouping: filterRecords) { record -> GroupKey in
        GroupKey(day: record.day, category: category(record))
    }
    
    //aggregation by metric parameter input
    let summed = grouped.map {key, group -> GenericSummary in
        let date = formatter.date(from: key.day) ?? Date()
        let total  = group.reduce(0.0) {$0 + metric($1)}
        return GenericSummary(day: date, category: key.category, cost: total)
    }
    
    //data sorted by ascending dates
    var final = summed.sorted {$0.day < $1.day}
    
    //apply limits to dates for data for 7, 30, 90 days, or custom
    if applyDayLimit {
        let uniqueDays = Set(summed.map { $0.day }).sorted().suffix(dayLimit)
        let dayLimitSet = Set(uniqueDays)
        
        final = final.filter{dayLimitSet.contains($0.day)}
    }
    
    //special functionality for WoW delta data creation
    if delta {
        let categories = Dictionary(grouping: final) {$0.category}
        var deltaResult: [GenericSummary] = []
        
        for (category, items) in categories {
            let sorted = items.sorted {$0.day < $1.day}
            for (index, item) in sorted.enumerated() {
                let previous = index > 0 ? sorted[index - 1].cost : item.cost
                let delta = item.cost - previous
                deltaResult.append(GenericSummary(day: item.day, category: category, cost: delta))
            }
        }
        final = deltaResult.sorted {$0.day < $1.day}
    }
    
    return final
}

//MARK: Generic Graph View maker
struct genericGraph: View {
    @Environment(AppData.self) private var appData
    
    let data: [GenericSummary]
    let title: String
    let ylabel: String
    let isDelta: Bool
    
    //function parameters
    init(data: [GenericSummary], title: String, ylabel: String, isDelta: Bool) {
        self.data = data
        self.title = title
        self.ylabel = ylabel
        self.isDelta = isDelta
    }
    
    var tickStride: Int {
        let dayCount = data.map {$0.day}.count
        switch dayCount {
        case 0...10: return 1
        case 11...30: return 5
        case 31...60: return 10
        default: return 14
        }
    }
    
    var body: some View {
        VStack {
            //title page
            Text(title).font(.headline).padding()
            // if statement for error message
            if data.isEmpty {
                Error().frame(maxWidth: .infinity, maxHeight: 300)
            //Datatable with no errors
            } else {
                //Specific for thirty minutes to fix labeling issue
                Chart(data) { item in
                    LineMark(
                        x: .value("date", item.day),
                        y: .value(ylabel, item.cost)
                    ).foregroundStyle(by: .value("Catagory", item.category))
                    
                    //Special zero x-axis line for WoW delta
                    if isDelta {
                        RuleMark(y: .value("Zero", 0)).foregroundStyle(.mint)
                    }
                }
                //x-axis adjustments
                .chartXAxisLabel("Date", alignment: .center)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day, count: tickStride)) { value in
                        AxisGridLine()
                        AxisTick()
                        if let date = value.as(Date.self) {
                            AxisValueLabel(anchor: .top) {
                                Text(date, format: .dateTime.month(.abbreviated).day())
                            }
                        }
                    }
                }
                //y-axis adjustments
                .chartYAxisLabel(ylabel, position: .trailing)
                .chartYAxis {
                    AxisMarks(values: .automatic(desiredCount: 10))
                }
                .frame(width: 650, height: 500)
                .chartLegend(position: .top)
            }
        }
    }
}

//MARK: Generic DataTable function (Issue with WoW seperate column names)
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
