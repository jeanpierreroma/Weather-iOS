//
//  VisibilityTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct VisibilityTodaySection: View {
    let date: Date
    let currentValue: Int
    let points: [MetricPoint]
    let dailySummary: String
    let todayPeak: Int
    let yesterdayPeak: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            ConditionChart(day: date, points: points, bands: VisibilityBands.standard, yDomain: 0...50, topAxisMode: .averageByBucket(hours: 2), yGridStep: 5)
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
            
            VisibilityDailySummarySection(dailySummary: dailySummary)
            
            VisibilityDailyComparisonSection(todayPeak: todayPeak, yesterdayPeak: yesterdayPeak)
            
            VisibilityAboutSection()
        }
    }
}

#Preview {
    let currentValue: Int = 32
    
    VisibilityTodaySection(
        date: .now,
        currentValue: 32,
        points: DemoData.mockVisibilityData(),
        dailySummary: "Today, the lowest visibility will be fairly clear at 5 km, and the highest will be perfectly clear at 35 km.",
        todayPeak: 35,
        yesterdayPeak: 30
    )
    .padding(.horizontal)
}
