//
//  SunMarkerStyle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct SunMarkerStyle: Sendable {
    public let color: Color
    public let diameter: CGFloat
    public let shadowRadius: CGFloat
    public let shadowOpacity: Double

    public init(color: Color, diameter: CGFloat, shadowRadius: CGFloat, shadowOpacity: Double) {
        self.color = color
        self.diameter = diameter
        self.shadowRadius = shadowRadius
        self.shadowOpacity = shadowOpacity
    }
}

public extension SunMarkerStyle {
    static let white = SunMarkerStyle(color: .white, diameter: 12, shadowRadius: 6, shadowOpacity: 0.85)
}
