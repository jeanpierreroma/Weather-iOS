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
    
    static func mockVisibilityData() -> [MetricPoint] {
        let cal   = Calendar.current
        let start = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
            3.0, 3.2, 3.5, 4.0, 5.0, 7.5,
            10.0, 13.0, 16.0, 18.5, 20.0, 20.0,
            19.0, 18.0, 17.0, 16.0, 14.5, 12.0,
            10.0, 8.5, 7.0, 6.0, 5.0, 4.0
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }

    /// Тиск, hPa (плавна добова варіація навколо ~1013 hPa)
    static func mockPressureDataHpa() -> [MetricPoint] {
        let cal   = Calendar.current
        let start = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
            1012.80, 1012.60, 1012.40, 1012.30, 1012.35, 1012.50,
            1012.75, 1013.00, 1013.25, 1013.45, 1013.60, 1013.65,
            1013.60, 1013.45, 1013.25, 1013.00, 1012.80, 1012.65,
            1012.55, 1012.50, 1012.55, 1012.70, 1012.90, 1013.00
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }

}
