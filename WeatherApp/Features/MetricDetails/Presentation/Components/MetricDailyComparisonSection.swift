//
//  MetricDailyComparisonSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct MetricDailyComparisonSection: View {
    let todayPeak: Int
    let yesterdayPeak: Int
    let comparisonSentence: String

    private var maxScale: Double {
        Double(max(todayPeak, yesterdayPeak))
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
    MetricDailyComparisonSection(
        todayPeak: 77,
        yesterdayPeak: 80,
        comparisonSentence: "Today’s peak humidity is slightly higher than yesterday by 3% (77% vs 80%)."
    )
}
