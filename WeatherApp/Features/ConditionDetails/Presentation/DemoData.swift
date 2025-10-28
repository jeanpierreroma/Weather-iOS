//
//  DemoData.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum DemoData {
    static func mockUVIData() -> [MetricPoint] {
        let cal  = Calendar.current
        let base = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: base) }

        let values: [Double] = [
            0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
            0.0, 0.0, 0.6, 2.1, 4.3, 6.4,
            7.5, 6.4, 4.6, 4.5, 3.5, 1.6,
            0.2, 0.0, 0.0, 0.0, 0.0, 0.0
        ]

        return zip(hours, values).map { .init(date: $0.0, value: $0.1) }
    }
    
    static func mockHumidityData() -> [MetricPoint] {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: .now)
        let hours = (0..<24).compactMap { calendar.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
            78.2, 79.4, 80.6, 82.1, 84.0, 86.1,
            88.0, 86.9, 84.2, 80.8, 76.6, 72.2,
            68.5, 64.9, 61.0, 56.2, 57.4, 60.3,
            64.1, 67.9, 71.2, 73.8, 75.6, 77.1
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }
}
