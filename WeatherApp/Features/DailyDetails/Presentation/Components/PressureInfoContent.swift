//
//  PressureInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

// MARK: - Content

struct PressureInfoContent: InfoBlockContent {
    var header = "Pressure"
    var headerIconSystemName = "gauge"
    
    let currentPressure: Int
    var minPressure: Int = 960
    var maxPressure: Int = 1065

    private var clamped: Int { currentPressure.clamped(to: minPressure...maxPressure) }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            PressureGauge(
                value: Double(clamped),
                minValue: Double(minPressure),
                maxValue: Double(maxPressure),
                style: .weather
            ) {
                VStack(spacing: 6) {
                    EqualBarsIcon()
                        .foregroundStyle(.white.opacity(0.9))

                    Text(Self.formattedNumber(hPa: clamped))
                        .metricValueStyle()

                    Text("hPa")
                        .metricCaptionStyle()
                }
            }
            .frame(height: 120) 
        }
    }

    // MARK: - Formatting helpers

    static func formattedNumber(hPa: Int) -> String {
        return hPa.formatted(.number.grouping(.automatic))
    }
}

private struct EqualBarsIcon: View {
    var body: some View {
        VStack(spacing: 3) {
            Capsule().frame(width: 18, height: 3)
            Capsule().frame(width: 18, height: 3)
            Capsule().frame(width: 18, height: 3)
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(
            content: PressureInfoContent(currentPressure: 996),
            kind: .clear,
            isNight: false
        )
            .padding()
    }
}
