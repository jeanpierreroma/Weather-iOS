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

    @Environment(\.pressureUnit) private var pressureUnit
    
    let currentPressure: Int
    var minPressure: Int = 980
    var maxPressure: Int = 1040

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

                    Text(Self.formattedNumber(hPa: clamped, unit: pressureUnit))
                        .metricValueStyle()

                    Text(pressureUnit.label)
                        .metricCaptionStyle()
                }
            }
        }
    }

    // MARK: - Formatting helpers

    static func formattedNumber(hPa: Int, unit: PressureDisplayUnit) -> String {
        switch unit {
        case .hPa:
            return hPa.formatted(.number.grouping(.automatic))
        case .mmHg:
            let mmHg = Int((Double(hPa) * 0.750061683).rounded())
            return mmHg.formatted(.number.grouping(.automatic))
        case .inHg:
            let inHg = Double(hPa) * 0.0295299830714
            return String(format: "%.2f", inHg)
        }
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

        InfoBlock(content: PressureInfoContent(currentPressure: 1024))
            .padding()
    }
}
