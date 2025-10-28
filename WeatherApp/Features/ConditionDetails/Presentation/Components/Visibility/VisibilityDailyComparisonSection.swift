//
//  VisibilityDailyComparisonSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct VisibilityDailyComparisonSection: View {
    let todayPeak: Int
    let yesterdayPeak: Int
    let maxScale: Double = 50
    
    private var comparisonSentence: String {
        let delta = todayPeak - yesterdayPeak
        let absDelta = abs(delta)

        // Інтенсивність як частка від maxScale (10% / 20%)
        let intensity: String = {
            let share = Double(absDelta) / maxScale
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
    VisibilityDailyComparisonSection(todayPeak: 35, yesterdayPeak: 30)
}
