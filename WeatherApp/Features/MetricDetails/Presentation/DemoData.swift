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

    /// Температура, °C (мінімум перед світанком ~05:00, пік близько 15:00)
    static func mockTemperatureDataCelsius() -> [MetricPoint] {
        let cal   = Calendar.current
        let start = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
            9.6, 9.2, 8.8, 8.5, 8.2, 8.0,
            8.3, 9.1, 10.4, 12.1, 13.9, 15.3,
            16.5, 17.3, 17.9, 18.0, 17.2, 16.0,
            14.5, 13.1, 12.0, 11.1, 10.4, 9.9
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }
    
    static func mockPrecipitationProbabilityData() -> [MetricPoint] {
        let cal   = Calendar.current
        let start = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
             5,  5,  4,  4,  6, 10,
            18, 28, 40, 52, 60, 68,
            72, 65, 58, 50, 42, 35,
            28, 20, 14, 10,  8,  6
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }
    
    static func mockWeatherSymbolsByHour(
        temperature: [MetricPoint] = mockTemperatureDataCelsius(),
        precipProb:  [MetricPoint] = mockPrecipitationProbabilityData()
    ) -> [Date: String] {
        let cal = Calendar.current

        func hourKey(_ d: Date) -> Date {
            cal.date(from: cal.dateComponents([.year, .month, .day, .hour], from: d))!
        }

        let tByHour = Dictionary(uniqueKeysWithValues: temperature.map { (hourKey($0.date), $0.value) })
        let pByHour = Dictionary(uniqueKeysWithValues: precipProb.map   { (hourKey($0.date), $0.value) })

        let allHours = Set(tByHour.keys).union(pByHour.keys)
        var result: [Date: String] = [:]

        for h in allHours {
            let hour = cal.component(.hour, from: h)
            let isNight = hour < 6 || hour >= 21
            let t  = tByHour[h] ?? 10
            let pp = pByHour[h] ?? 0

            let symbol: String
            if pp >= 80 {
                symbol = "cloud.heavyrain.fill"
            } else if pp >= 50 {
                symbol = "cloud.rain.fill"
            } else if pp >= 20 {
                symbol = "cloud.drizzle.fill"
            } else {
                if isNight {
                    if t <= 2 { symbol = "cloud.moon.fill" }
                    else      { symbol = "moon.stars.fill" }
                } else {
                    if t >= 16 { symbol = "sun.max.fill" }
                    else if t >= 10 { symbol = "cloud.sun.fill" }
                    else { symbol = "cloud.fill" }
                }
            }

            result[h] = symbol
        }

        return result
    }
    
    /// Feels Like, °C (трохи нижча вночі через вітер, трохи вища опівдні через сонце)
    static func mockFeelsLikeTemperatureDataCelsius() -> [MetricPoint] {
        let cal   = Calendar.current
        let start = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: start) }

        let values: [Double] = [
             8.5,  8.1,  7.7,  7.3,  7.0,  6.8,
             7.2,  8.1,  9.6, 11.6, 13.6, 15.8,
            17.2, 18.0, 18.5, 18.3, 17.4, 15.8,
            14.0, 12.6, 11.5, 10.6, 10.0,  9.4
        ]

        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }
}
