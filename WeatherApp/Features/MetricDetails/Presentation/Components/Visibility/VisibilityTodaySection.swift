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
            MetricChart(day: date, points: points, bands: VisibilityBands.standard, yDomain: 0...50, topAxisMode: .averageByBucket(hours: 2), yGridStep: 5)
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
            
            VisibilityDailySummarySection(dailySummary: dailySummary)
            
            MetricDailyComparisonSection(
                todayPeak: todayPeak,
                yesterdayPeak: yesterdayPeak,
                comparisonSentence: comparisonSentence
            )
                        
            MetricAboutSection(
                title: "About Visibility",
                text: """
    Visibility tells you how far away you can clearly see objects like buildings and hills. It is a measure of the transparency of the air and does not take into account the amount of sunlight or the presence of obstructions. Visibility at or above 10 km is considered clear.
    """
            )
        }
    }
    
    private var comparisonSentence: String {
        let delta = todayPeak - yesterdayPeak
        let absDelta = abs(delta)

        let intensity: String = {
            let share = Double(absDelta) / 100
            switch share {
            case 0:            return ""
            case ..<0.10:      return "slightly "
            case ..<0.20:      return "moderately "
            default:           return "significantly "
            }
        }()

        if delta == 0 {
            return "Today’s peak visibility matches yesterday’s (\(todayPeak) km)."
        } else if delta > 0 {
            return "Today’s peak visibility is \(intensity)higher than yesterday by \(absDelta) km (\(todayPeak) km vs \(yesterdayPeak) km)."
        } else {
            return "Today’s peak visibility is \(intensity)lower than yesterday by \(absDelta) km (\(todayPeak) km vs \(yesterdayPeak) km)."
        }
    }
}

#Preview {
    let currentValue: Int = 32
    
    ScrollView {
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
}
