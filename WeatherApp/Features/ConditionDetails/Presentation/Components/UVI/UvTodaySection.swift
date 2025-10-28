//
//  UvTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct UvTodaySection: View {
    let date: Date
    let currentValue: Int
    let points: [MetricPoint]
    let guidanceText: String       

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                (Text("\(currentValue) ").font(.title2.weight(.semibold)).monospacedDigit()
                 + Text("High").font(.headline))
                    .foregroundStyle(.primary)

                Text("WHO UV Index (UVI)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            ConditionChart(day: date, points: points, bands: UVIBands.standard, yDomain: 0...11)
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text("Now • \(Date.now.formatted(date: .omitted, time: .shortened))")
                    .font(.callout.weight(.semibold))
                Text(guidanceText)
                    .font(.callout)
            }
        }
    }
}

#Preview {
    let currentValue: Int = 6
    
    let cal = Calendar.current
    let base = cal.startOfDay(for: .now)
    let hours = (0..<24).compactMap { cal.date(byAdding: .hour, value: $0, to: base) }
    
    let values = hours.map { d -> Double in
        let h = Double(cal.component(.hour, from: d)) + Double(cal.component(.minute, from: d))/60
        return uvi(atHour: h)
    }
    
    let points: [MetricPoint] = zip(hours, values).map { MetricPoint(date: $0.0, value: $0.1) }
    
    func uvi(atHour h: Double) -> Double {
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
    
    
    return UvTodaySection(
        date: .now,
        currentValue: currentValue,
        points: points,
        guidanceText: ""
    )
}
