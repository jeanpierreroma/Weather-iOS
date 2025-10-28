//
//  UvDailyComparisonSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct UvDailyComparisonSection: View {
    let todayPeak: Int
    let yesterdayPeak: Int
    let maxScale: Double = 11
    
    var comparisonSentence: String {
        if todayPeak == yesterdayPeak { return "The peak UV index today is the same as yesterday." }
        return todayPeak < yesterdayPeak
        ? "The peak UV index today is lower than yesterday."
        : "The peak UV index today is higher than yesterday."
    }

    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Daily Comparison")
            SectionCard(comparisonSentence) {
                LabeledBar(label: "Today",     value: Double(todayPeak),     maxValue: maxScale, highlight: true)
                LabeledBar(label: "Yesterday", value: Double(yesterdayPeak), maxValue: maxScale)
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    UvDailyComparisonSection(todayPeak: 1, yesterdayPeak: 2)
}
