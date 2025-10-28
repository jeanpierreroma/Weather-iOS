//
//  UVIDetailsPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum UVIDetailsPresenter {
    static func props() -> UVIDetailsProps {
        .init(
            points: makePoints(),
            currentValue: 6,
            guidanceText: "Sun protection recommended. Levels of Moderate or higher are reached from 09:00 to 17:00",
            todayPeak: 1,
            yesterdayPeak: 3
        )
    }
    
    private static func makePoints() -> [MetricPoint] {
        let cal = Calendar.current
        let base = cal.startOfDay(for: .now)
        let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: base) }
        
        let values = hours.map { d -> Double in
            let h = Double(cal.component(.hour, from: d)) + Double(cal.component(.minute, from: d))/60
            return Self.uvi(atHour: h)
        }
        
        return zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    }
    
    private static func uvi(atHour h: Double) -> Double {
        let sunrise = 6.8, sunset = 18.4, peak = 12.3
        
        guard h >= sunrise, h <= sunset else { return 0 }
        let span = sunset - sunrise
        let x = (h - sunrise) / span
        let riseGamma = 2.3, fallGamma = 1.6
        let base = pow(sin(.pi * x), x < (peak - sunrise)/span ? riseGamma : fallGamma)
        let dip = 1.0 - 0.35 * exp(-0.5 * pow((h - 14.0)/0.9, 2))
        let v = 8.0 * base * dip
        return max(0, min(11, v))
    }
}
