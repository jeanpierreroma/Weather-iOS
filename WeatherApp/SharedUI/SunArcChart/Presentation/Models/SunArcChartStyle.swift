//
//  SunArcChartStyle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct SunArcChartStyle: Sendable {
    public let baselineFraction: CGFloat     // 0…1 (0 — верх, 1 — низ)
    public let amplitudeFraction: CGFloat    // 0…0.5
    public let verticalOffset: CGFloat       // ~0…0.3
    public let overscanFraction: CGFloat     // «виліт» за краї
    public let cornerRadius: CGFloat
    public let lineWidth: CGFloat
    public let strokeGradient: LinearGradient

    public init(
        baselineFraction: CGFloat,
        amplitudeFraction: CGFloat,
        verticalOffset: CGFloat,
        overscanFraction: CGFloat,
        cornerRadius: CGFloat,
        lineWidth: CGFloat,
        strokeGradient: LinearGradient
    ) {
        self.baselineFraction = baselineFraction
        self.amplitudeFraction = amplitudeFraction
        self.verticalOffset = verticalOffset
        self.overscanFraction = overscanFraction
        self.cornerRadius = cornerRadius
        self.lineWidth = lineWidth
        self.strokeGradient = strokeGradient
    }
}

public extension SunArcChartStyle {
    static func weather(gradient: LinearGradient) -> SunArcChartStyle {
        .init(
            baselineFraction: 0.50,
            amplitudeFraction: 0.28,
            verticalOffset: 0.12,
            overscanFraction: 0.18,
            cornerRadius: 32,
            lineWidth: 3,
            strokeGradient: gradient
        )
    }
}
