//
//  Linear Regression.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
import Cocoa
import SwiftUI
import Charts
//MARK: Generic aggregation function
func makeRegressionPoints(from data: [GenericSummary], daysAhead: Int = 30, category: String, appData: AppData
) -> [GenericSummary] {
    
    //Prepartion using given data
    let sorted = data.sorted {$0.day < $1.day}
    let firstDay = sorted.first?.day ?? Date()
    
    //Points for all the data given
    let points: [(x: Double, y: Double)] = sorted.map { item in
        let daySinceStart = item.day.timeIntervalSince(firstDay) / 86400
        return (x: daySinceStart, y: item.cost)
    }
    appData.points = points
    
    //Use Linear Regression on given data
    guard let regression = computeLinearRegression(points: points, appData: appData) else {return []}
    
    //Calculate for last days
    let lastDate = sorted.last?.day ?? Date()
    let lastDays = lastDate.timeIntervalSince(firstDay)
    
    var forecastPoints: [GenericSummary] = []
    
    //For each day after the last date, add that day as a Date() along with predicted cost into forecastPoints
    for day in 1...daysAhead {
        let futureDays = lastDays + Double(day)
        let futureDate = lastDate.addingTimeInterval(Double(day) * 86400)
        let predictCost = max(0, regression.predict(x: futureDays))
        
        forecastPoints.append(GenericSummary(day: futureDate, category: category, cost: predictCost))
    }
    
    return forecastPoints
}

func computeLinearRegression(points: [(x: Double, y: Double)], appData: AppData) -> LinearRegression? {
    let n = Double(points.count)
    guard n > 2 else { return nil }
    
    //All components
    let xSum = points.reduce(0.0) {$0 + $1.x}
    let ySum = points.reduce(0.0) {$0 + $1.x}
    let xySum = points.reduce(0.0) {$0 + $1.x * $1.y}
    let xSquared = points.reduce(0.0) {$0 + $1.x * $1.x}
    let ySquared = points.reduce(0.0) {$0 + $1.y * $1.y}
    
    //Slope calculation
    let slopeNumer = (n * xySum) - (xSum * ySum)
    let slopeDenom = (n * xSquared) - (xSum * xSum)
    guard slopeDenom != 0 else {return nil}
    
    let slope = slopeNumer / slopeDenom
    //Intercept calculation
    let intercept = (ySum - (slope * xSum)) / n
    
    //R^2 calculation
    let yMean = ySum / n
    let totalVariance = points.reduce(0.0) {$0 + pow($1.y - yMean, 2)}
    let residualVariance = points.reduce(0.0) {$0 + pow($1.y - (slope * $1.x + intercept), 2)}
    let rSquared = totalVariance == 0 ? 1.0: 1.0 - (totalVariance / residualVariance)
    
    appData.slope = slope
    appData.intercept = intercept
    appData.rSquared = rSquared
    appData.totalVariance = totalVariance
    
    return LinearRegression(slope: slope, intercept: intercept, rSquared: rSquared)
}
