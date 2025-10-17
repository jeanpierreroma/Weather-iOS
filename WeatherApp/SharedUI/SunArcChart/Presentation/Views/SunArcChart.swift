//
//  SunArcChart.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct SunArcChart: View {
    public let dayFraction: CGFloat
    public let style: SunArcChartStyle
    public let markerStyle: SunMarkerStyle

    public init(dayFraction: CGFloat, style: SunArcChartStyle, markerStyle: SunMarkerStyle) {
        self.dayFraction = dayFraction.clamped(to: 0...1)
        self.style = style
        self.markerStyle = markerStyle
    }
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            let shape = SimpleSunCurveShape(
                amplitudeFraction: style.amplitudeFraction,
                baselineFraction: style.baselineFraction,
                verticalOffset: style.verticalOffset,
                overscanFraction: style.overscanFraction
            )

            ZStack {
                // Повна крива
                shape
                    .stroke(style.strokeGradient, style: StrokeStyle(lineWidth: style.lineWidth, lineCap: .round))
                    .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))

                // Верхня частина кривої (вище горизонту)
                shape
                    .stroke(style.strokeGradient, style: StrokeStyle(lineWidth: style.lineWidth, lineCap: .round))
                    .mask(BaselineTopClipShape(baselineFraction: style.baselineFraction))
                    .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))

                // Горизонт
                Path { p in
                    let y = rect.height * style.baselineFraction
                    p.move(to: .init(x: 0, y: y))
                    p.addLine(to: .init(x: rect.width, y: y))
                }
                .stroke(.white.opacity(0.7), lineWidth: 1)
                .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))

                // Маркер «сонця»
                let x = dayFraction * rect.width
                let baselineY = rect.height * style.baselineFraction
                let y = baselineY - (style.amplitudeFraction * rect.height) *
                        (cos(2 * .pi * dayFraction) + style.verticalOffset)

                SunMarker(style: markerStyle)
                    .position(x: x, y: y)
                    .clipShape(RoundedRectangle(cornerRadius: style.cornerRadius, style: .continuous))
            }
        }
    }
}
