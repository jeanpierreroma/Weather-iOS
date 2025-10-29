//
//  HumidityDetailsProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

struct HumidityDetailsProps {
    let currentValue: Int
    let points: [MetricPoint]
    let dailySummary: String
    let todayPeak: Int
    let yesterdayPeak: Int
}
