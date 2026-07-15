//
//  OverviewSummary.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/14/26.
//
struct OverviewSummary {
    let totalCost: Double
    let dailyAverage: Double
    let highestDayCost: Double
    let lowestDayCost: Double
    let costTrend: Double
    let daysAboveAverage: Int
}
func makeOverviewSummary(from data: [GenericSummary]) -> OverviewSummary {
    let sorted = data.sorted {$0.day < $1.day}
    
    let total = data.reduce(0.0) { $0 + $1.cost }
    let uniqueDays = Set(data.map {$0.day}).count
    let dailyAverage = uniqueDays > 0 ? total / Double(uniqueDays) : 0
    
    let midpoint = sorted.count / 2
    let firstHalf = sorted.prefix(midpoint)
    let secondHalf = sorted.suffix(sorted.count - midpoint)
    
    let firstAvg = firstHalf.reduce(0.0) { $0 + $1.cost } / Double(max(1, firstHalf.count))
    let secondAvg = secondHalf.reduce(0.0) { $0 + $1.cost } / Double(max(1, secondHalf.count))
        
    return OverviewSummary(totalCost: total, dailyAverage: dailyAverage, highestDayCost: data.map(\.cost).max() ?? 0,
                           lowestDayCost: data.map(\.cost).min() ?? 0, costTrend: secondAvg - firstAvg,
                           daysAboveAverage: data.filter {$0.cost > dailyAverage}.count)
    
}

