//
//  SunSamplePoint.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 15.10.2025.
//

import Foundation

struct SunSamplePoint: Identifiable {
    let id = UUID()
    let date: Date
    let elevationDegrees: Double
    var fractionOfDay: Double // 0...1
}
