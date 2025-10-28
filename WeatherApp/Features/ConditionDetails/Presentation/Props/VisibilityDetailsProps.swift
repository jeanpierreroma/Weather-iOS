//
//  VisibilityDetailsProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

struct VisibilityDetailsProps {
    let points: [MetricPoint]
    let currentValue: Int
    let dailySummary: String
    let todayPeak: Int
    let yesterdayPeak: Int
}
