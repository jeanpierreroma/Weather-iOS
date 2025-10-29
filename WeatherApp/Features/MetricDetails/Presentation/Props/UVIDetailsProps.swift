//
//  UVIDetailsProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

struct UVIDetailsProps {
    let points: [MetricPoint]
    let currentValue: Int
    let guidanceText: String
    let todayPeak: Int
    let yesterdayPeak: Int
}
