//
//  SimpleSunCurveShape.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct SimpleSunCurveShape: Shape {
    public let amplitudeFraction: CGFloat
    public let baselineFraction: CGFloat
    public let verticalOffset: CGFloat
    public let overscanFraction: CGFloat

    public init(amplitudeFraction: CGFloat, baselineFraction: CGFloat, verticalOffset: CGFloat, overscanFraction: CGFloat) {
        self.amplitudeFraction = amplitudeFraction
        self.baselineFraction = baselineFraction
        self.verticalOffset = verticalOffset
        self.overscanFraction = overscanFraction
    }

    public func path(in rect: CGRect) -> Path {
        let baselineY = rect.minY + baselineFraction * rect.height
        let amplitude = amplitudeFraction * rect.height
        let xStart = -overscanFraction
        let xEnd: CGFloat = 1 + overscanFraction
        let step: CGFloat = 1.0 / 160.0

        var p = Path()
        var first = true
        var x = xStart
        while x <= xEnd + 0.0001 {
            let xVisible = Swift.max(0, Swift.min(1, x)) // явні Swift.min/max щоб уникнути тіньових конфліктів
            let y = baselineY - amplitude * (cos(2 * .pi * xVisible) + verticalOffset)
            let px = rect.minX + (x * rect.width)
            if first { p.move(to: CGPoint(x: px, y: y)); first = false }
            else { p.addLine(to: CGPoint(x: px, y: y)) }
            x += step
        }
        return p
    }
}
