//
//  AveragesInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import SwiftUI

struct AveragesInfoContent: InfoBlockContent {
    var header = "Averages"
    
    let props: AveragesProps
    
    var headerIconSystemName = "chart.line.uptrend.xyaxis"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(props.differenceText)
                .metricValueStyle()
            
            Text(props.summary)
                .metricCaptionStyle()
                .fontWeight(.semibold)
            
            VStack {
                MetricRow(title: "Today",   value: props.todayAverageText)
                MetricRow(title: "Average", value: props.averageText)
            }
        }
    }
}

private struct MetricRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.footnote)
                .foregroundStyle(.secondary)

            Spacer(minLength: 8)

            Text(value)
                .font(.subheadline.weight(.semibold))
                .monospacedDigit()
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ZStack {
        WeatherGradients.gradient(for: .clear, isNight: false)
        
        InfoBlock(
            content: AveragesInfoContent(
                props: .init(
                    differenceText: "+8°",
                    summary: "above average daily high",
                    todayAverageText: "H:17°",
                    averageText: "H:9°"
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
