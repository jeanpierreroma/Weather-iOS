//
//  PressureGauge.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct PressureGauge<Center: View>: View {
    /// Значення в hPa
    public let value: Double
    public let minValue: Double
    public let maxValue: Double
    public let style: PressureGaugeStyle
    @ViewBuilder public let center: () -> Center

    public init(
        value: Double,
        minValue: Double,
        maxValue: Double,
        style: PressureGaugeStyle,
        @ViewBuilder center: @escaping () -> Center
    ) {
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.style = style
        self.center = center
    }

    public var body: some View {
        GeometryReader { geo in
            let side = min(geo.size.width, geo.size.height)
            let radius = side * style.radiusFraction
            let tickLen = side * style.tickLengthFraction
            let tickWidth = max(2, side * style.tickWidthFraction)
            let needleWidth = max(6, side * style.needleWidthFraction)
            let needleLen = side * style.needleLengthFraction

            let norm = normalized(value: value, min: minValue, max: maxValue)
            let angle = Angle(degrees: style.startAngle.degrees +
                              (style.endAngle.degrees - style.startAngle.degrees) * norm)

            ZStack {
                // Тіки
                GaugeTickRing(
                    startAngle: style.startAngle,
                    endAngle: style.endAngle,
                    tickCount: style.tickCount,
                    radius: radius,
                    tickLength: tickLen,
                    tickWidth: tickWidth,
                    color: style.tickColor
                )

                // Стрілка
                Capsule()
                    .frame(width: needleWidth, height: needleLen)
                    .foregroundStyle(style.needleColor)
                    .shadow(radius: 1, y: 1)
                    .offset(y: -(radius + needleLen * 0.15))
                    .rotationEffect(angle)

                // Центровий контент
                center()
                
                HStack(spacing: 20) {
                    Text("Low").metricCaptionStyle()
                    Text("High").metricCaptionStyle()
                }
                .padding(.top, radius * 2)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func normalized(value: Double, min: Double, max: Double) -> Double {
        guard max > min else { return 0.5 }
        return ((value - min) / (max - min)).clamped(to: 0...1)
    }
}

private struct GaugeTickRing: View {
    let startAngle: Angle
    let endAngle: Angle
    let tickCount: Int
    let radius: CGFloat
    let tickLength: CGFloat
    let tickWidth: CGFloat
    let color: Color

    var body: some View {
        ForEach(0...tickCount, id: \.self) { i in
            let frac = Double(i) / Double(tickCount)
            let a = Angle(degrees: startAngle.degrees + (endAngle.degrees - startAngle.degrees) * frac)

            Capsule()
                .frame(width: tickWidth, height: tickLength)
                .foregroundStyle(color)
                .offset(y: -radius)
                .rotationEffect(a)
                .accessibilityHidden(true)
        }
    }
}
