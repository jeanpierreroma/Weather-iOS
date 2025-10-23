//
//  HourForecastPoint.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation

struct HourForecastPoint: Identifiable {
    var id: Date { date }
    
    let date: Date
    let temperature: Double
    let symbol: String
}
