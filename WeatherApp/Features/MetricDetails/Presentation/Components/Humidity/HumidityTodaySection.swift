//
//  HumidityTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct HumidityTodaySection: View {
    let date: Date
    let currentValue: Int
    let points: [MetricPoint]
    let dailySummary: String
    let todayPeak: Int
    let yesterdayPeak: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                (Text("\(currentValue) ").font(.title2.weight(.semibold)).monospacedDigit()
                 + Text("%").font(.headline))
                    .foregroundStyle(.primary)

                Text("Dew point is 23°")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            ConditionChart(day: date, points: points, bands: HumidityBands.standard, yDomain: 0...100, topAxisMode: .averageByBucket(hours: 6), yGridStep: 20)
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
            
            HumidityDailySummarySection(dailySummary: dailySummary)
            
            HumidityDailyComparisonSection(todayPeak: todayPeak, yesterdayPeak: yesterdayPeak)
            
            RelativeHumidityAboutSection()
            
            DewPointAboutSection()
        }
    }
}

#Preview {
    let currentValue: Int = 6
    
    HumidityTodaySection(
        date: .now,
        currentValue: currentValue,
        points: DemoData.mockHumidityData(),
        dailySummary: "Today, the average humidity is 80%. The dew point is 23 all day.",
        todayPeak: 80,
        yesterdayPeak: 77
    )
    .padding(.horizontal)
}
