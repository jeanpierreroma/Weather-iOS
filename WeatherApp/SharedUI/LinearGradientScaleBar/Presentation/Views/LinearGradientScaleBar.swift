//
//  AirQualityScaleView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//


import SwiftUI

struct LinearGradientScaleBar: View {
    let totalRange: ClosedRange<Double>
    let colorStops: [(value: Double, color: Color)]
    let value: Double

    let barStyle: ScaleBarStyle
    let indicatorStyle: ScaleIndicatorStyle

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let stops = gradientStops(totalRange: totalRange, colorStops: colorStops)

            ZStack {
                // Бар із градієнтом
                RoundedRectangle(cornerRadius: barStyle.cornerRadius, style: .continuous)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: stops),
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    .frame(height: barStyle.barHeight)

                // Індикатор
                let clamped = value.clamped(to: totalRange)
                let x = xPosition(for: clamped, in: totalRange, totalWidth: width)

                ScaleIndicator(style: indicatorStyle)
                    .position(x: x, y: barStyle.barHeight / 2)
            }
        }
    }

    // MARK: - Helpers

    private func xPosition(for value: Double, in range: ClosedRange<Double>, totalWidth: CGFloat) -> CGFloat {
        let f = (value - range.lowerBound) / max(1e-9, (range.upperBound - range.lowerBound))
        return CGFloat(f.clamped(to: 0...1)) * totalWidth
    }

    private func gradientStops(totalRange: ClosedRange<Double>, colorStops: [(value: Double, color: Color)]) -> [Gradient.Stop] {
        let lower = totalRange.lowerBound
        let upper = totalRange.upperBound
        let denom = max(1e-9, upper - lower)

        var s = colorStops.sorted { $0.value < $1.value }
        if let first = s.first, first.value > lower { s.insert((lower, first.color), at: 0) }
        if let last  = s.last,  last.value  < upper { s.append((upper, last.color)) }

        return s.map { pair in
            let loc = ((pair.value - lower) / denom).clamped(to: 0...1)
            return Gradient.Stop(color: pair.color, location: CGFloat(loc))
        }
    }
}

#Preview("Default – AQI") {
    ZStack {
        LinearGradient(
            colors: [.indigo, .purple, .pink],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        LinearGradientScaleBar(
            totalRange: 0...500,
            colorStops: [
                (0,   .green),
                (50,  .green),
                (100, .yellow),
                (200, .orange),
                (300, .red),
                (500, .purple)
            ],
            value: 170,
            barStyle: .init(barHeight: 6, cornerRadius: 3),
            indicatorStyle: .init(color: .white, diameter: 12, shadowRadius: 2, shadowOpacity: 0.45)
        )
        .padding(24)
    }
    .frame(height: 60)
}

#Preview("UV 0…11") {
    ZStack {
        LinearGradient(
            colors: [.indigo, .purple, .pink],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        LinearGradientScaleBar(
            totalRange: 0...11,
            colorStops: [
                (0, .green), (2, .green),
                (3, .yellow), (5, .yellow),
                (6, .orange), (7, .orange),
                (8, .red), (10, .red),
                (11, .purple)
            ],
            value: 8,
            barStyle: .init(barHeight: 6, cornerRadius: 3),
            indicatorStyle: .init(color: .white, diameter: 12, shadowRadius: 2, shadowOpacity: 0.45)
        )
        .padding()
    }
    .frame(height: 40)
}
