//
//  LinearRegression.swift
//  Buttery_Internship
//
//  Created by Jason Zhang on 7/17/26.
//
struct LinearRegression {
    let slope: Double
    let intercept: Double
    let rSquared: Double
    
    func predict(x: Double) -> Double {
        return slope * x + intercept
    }
}
