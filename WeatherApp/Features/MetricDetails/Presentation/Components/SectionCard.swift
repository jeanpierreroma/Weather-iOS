//
//  SectionCard.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct SectionCard<Content: View>: View {
    let title: String?
    @ViewBuilder var content: Content

    init(_ title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title).font(.headline)
                    .padding(.horizontal)
                    
                
                Divider()
            }
            
            content
                .padding(.horizontal)
                
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.black.opacity(0.15))
        )
    }
}

#Preview {
    let todayPeak = 1
    let yesterdayPeak = 2
    
    var comparisonSentence: String {
        if todayPeak == yesterdayPeak { return "The peak UV index today is the same as yesterday." }
        return todayPeak < yesterdayPeak
        ? "The peak UV index today is lower than yesterday."
        : "The peak UV index today is higher than yesterday."
    }
    
    SectionCard(comparisonSentence) {
        LabeledBar(label: "Today",     value: Double(todayPeak),     maxValue: 2, highlight: true)
        LabeledBar(label: "Yesterday", value: Double(yesterdayPeak), maxValue: 2)
    }
}
