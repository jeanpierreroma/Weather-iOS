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
            MetricChart(
                day: date,
                points: points,
                bands: HumidityBands.standard,
                yDomain: 0...100,
                topAxisMode: .averageByBucket(hours: 6),
                yGridStep: 20
            )
            .padding(.trailing)
            .padding(.top, 8)
            .padding(.bottom, 4)
            .frame(height: 320)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 0.1))
            )
            
            HumidityDailySummarySection(dailySummary: dailySummary)
            
            MetricDailyComparisonSection(
                todayPeak: todayPeak,
                yesterdayPeak: yesterdayPeak,
                comparisonSentence: comparisonSentence
            )
            
            MetricAboutSection(
                title: "About Relative Humidity",
                text: """
    Relative humidity, commonly know just as humidity, is the amount of moisture in the air compared with what the air can hold. The air can hold more moisture at higher temperatures. A relative humidity near 100% mean there may be dew or fog.
    """
            )
                       
            MetricAboutSection(
                title: "About Dew Point",
                text: """
    The dew point is what the temperature would need to fall to for dew to form. It can be a useful way to tell how humid the air feels - the higher the dew point, the more humid it feels. A dew point that matches the current temperature means the relative humidity is 100%, and there may be dew or fog.
    """
            )
        }
    }
    
    private var comparisonSentence: String {
        let delta = todayPeak - yesterdayPeak
        let absDelta = abs(delta)

        let intensity: String = {
            switch absDelta {
            case 0: return ""
            case 1...4: return "slightly "
            case 5...9: return "moderately "
            default: return "significantly "
            }
        }()

        func pp(_ n: Int) -> String { n == 1 ? "percentage point" : "percentage points" }

        if delta == 0 {
            return "Today’s peak humidity matches yesterday’s (\(todayPeak)%)."
        } else if delta > 0 {
            return "Today’s peak humidity is \(intensity)higher than yesterday by \(absDelta) \(pp(absDelta)) (\(todayPeak)% vs \(yesterdayPeak)%)."
        } else {
            return "Today’s peak humidity is \(intensity)lower than yesterday by \(absDelta) \(pp(absDelta)) (\(todayPeak)% vs \(yesterdayPeak)%)."
        }
    }
}

#Preview {
    let currentValue: Int = 6
    
    ScrollView {
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
}
