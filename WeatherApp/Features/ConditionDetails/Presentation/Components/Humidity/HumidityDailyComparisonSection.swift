//
//  HumidityDailyComparisonSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct HumidityDailyComparisonSection: View {
    let todayPeak: Int
    let yesterdayPeak: Int
    let maxScale: Double = 100
    
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

    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Daily Comparison")
            SectionCard(comparisonSentence) {
                LabeledBar(label: "Today", value: Double(todayPeak), maxValue: maxScale, highlight: true)
                LabeledBar(label: "Yesterday", value: Double(yesterdayPeak), maxValue: maxScale)
            }
        }
        
    }
}

#Preview {
    HumidityDailyComparisonSection(todayPeak: 80, yesterdayPeak: 77)
}
