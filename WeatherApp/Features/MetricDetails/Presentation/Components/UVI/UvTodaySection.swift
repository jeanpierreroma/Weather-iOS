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
    let todayPeak: Int
    let yesterdayPeak: Int

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

            ConditionChart(day: date, points: points, bands: UVIBands.standard, yDomain: 0...11, topAxisMode: .perHour)
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
            
            Divider()
            
            UvDailyComparisonSection(
                todayPeak: todayPeak,
                yesterdayPeak: yesterdayPeak
            )
            
            UvAboutSection()
        }
    }
}

#Preview {
    let currentValue: Int = 6
    
    UvTodaySection(
        date: .now,
        currentValue: currentValue,
        points: DemoData.mockUVIData(),
        guidanceText: "",
        todayPeak: 6,
        yesterdayPeak: 4
    )
    .padding(.horizontal)
}
