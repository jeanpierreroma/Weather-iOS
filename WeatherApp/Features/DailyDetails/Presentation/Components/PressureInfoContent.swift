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
    var minPressure: Int = 300
    var maxPressure: Int = 1100

    private var clamped: Int { currentPressure.clamped(to: minPressure...maxPressure) }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
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

enum PressureDisplayUnit: String, CaseIterable, Sendable {
    case hPa, mmHg, inHg

    var label: String {
        switch self {
        case .hPa:  return "hPa"
        case .mmHg: return "mmHg"
        case .inHg: return "inHg"
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(
            content: PressureInfoContent(currentPressure: 1024),
            kind: .clear,
            isNight: false
        )
            .padding()
    }
}
