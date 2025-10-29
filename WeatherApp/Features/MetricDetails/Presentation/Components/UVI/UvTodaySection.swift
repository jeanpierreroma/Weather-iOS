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
            MetricChart(day: date, points: points, bands: UVIBands.standard, yDomain: 0...11, topAxisMode: .perHour)
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
            
            MetricDailyComparisonSection(
                todayPeak: todayPeak,
                yesterdayPeak: yesterdayPeak,
                comparisonSentence: comparisonSentence
            )
                        
            MetricAboutSection(
                title: "About the UV Index",
                text: """
    The UV Index (UVI) indicates the strength of ultraviolet radiation from the sun. Higher values mean faster skin and eye damage. As a rule of thumb, start using shade, sunscreen, hats and protective clothing from level 3 (Moderate) and above.
    """
            )
        }
    }
    
    private var comparisonSentence: String {
        if todayPeak == yesterdayPeak {
            return "The peak UV index today is the same as yesterday."
        }
        
        return todayPeak < yesterdayPeak
            ? "The peak UV index today is lower than yesterday."
            : "The peak UV index today is higher than yesterday."
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
