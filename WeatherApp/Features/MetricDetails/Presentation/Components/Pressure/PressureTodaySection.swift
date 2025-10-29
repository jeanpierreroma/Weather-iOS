//
//  PressureTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct PressureTodaySection: View {
    let date: Date
    let currentValue: Int
    let points: [MetricPoint]
    let dailySummary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ConditionChart(day: date, points: points, bands: PressureBands.standard, yDomain: 930...1100, topAxisMode: .averageByBucket(hours: 6), yGridStep: 15)
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
            
            PressureDailySummarySection(dailySummary: dailySummary)
                        
            MetricAboutSection(
                title: "About Pressure",
                text: """
    Significant, rapid changes in pressure are used to predict changes in the weather. For example, a drop in pressure can mean that rain or snow is on the way, and rising pressure can mean that weather will improve. Pressure is also called barometric pressure or atmospheric pressure.
    """
            )
        }
    }
}

#Preview {
    let currentValue: Int = 1010
    
    PressureTodaySection(
        date: .now,
        currentValue: currentValue,
        points: DemoData.mockPressureDataHpa(),
        dailySummary: "Pressure is currently 1 010 hPa and rising. Today, the average pressure will be 1 006 hPa, and the lowest pressure will be 1 003 hPa."
    )
}
