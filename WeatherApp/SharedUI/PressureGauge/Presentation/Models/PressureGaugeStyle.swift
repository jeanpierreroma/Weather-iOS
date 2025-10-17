//
//  PressureGaugeStyle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct PressureGaugeStyle: Sendable {
    public let startAngle: Angle
    public let endAngle: Angle
    public let tickCount: Int

    public let radiusFraction: CGFloat
    public let tickLengthFraction: CGFloat
    public let tickWidthFraction: CGFloat
    public let needleWidthFraction: CGFloat
    public let needleLengthFraction: CGFloat

    public let tickColor: Color
    public let needleColor: Color

    public init(
        startAngle: Angle,
        endAngle: Angle,
        tickCount: Int,
        radiusFraction: CGFloat,
        tickLengthFraction: CGFloat,
        tickWidthFraction: CGFloat,
        needleWidthFraction: CGFloat,
        needleLengthFraction: CGFloat,
        tickColor: Color,
        needleColor: Color
    ) {
        self.startAngle = startAngle
        self.endAngle = endAngle
        self.tickCount = tickCount
        self.radiusFraction = radiusFraction
        self.tickLengthFraction = tickLengthFraction
        self.tickWidthFraction = tickWidthFraction
        self.needleWidthFraction = needleWidthFraction
        self.needleLengthFraction = needleLengthFraction
        self.tickColor = tickColor
        self.needleColor = needleColor
    }
}

public extension PressureGaugeStyle {
    static let weather = PressureGaugeStyle(
        startAngle: .degrees(-135),
        endAngle: .degrees(135),
        tickCount: 28,
        radiusFraction: 0.45,
        tickLengthFraction: 0.10,
        tickWidthFraction: 0.02,
        needleWidthFraction: 0.035,
        needleLengthFraction: 0.18,
        tickColor: .white.opacity(0.28),
        needleColor: .white
    )
}
