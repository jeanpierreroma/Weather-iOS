//
//  UVPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

enum UVPresenter {
    static var defaultStops: [(Double, Color)] {
        [
            (0,  Color(hex: "#2E7D32")), // Low
            (3,  Color(hex: "#FFEB3B")), // Moderate
            (6,  Color(hex: "#EF5350")), // High
            (8,  Color(hex: "#EF5350")), // Very High
            (11, Color(hex: "#51087E"))  // Extreme
        ].map { (Double($0.0), $0.1) }
    }

    static func props(from details: UVDetails, stops: [(Double, Color)] = defaultStops) -> UVProps {
        .init(
            valueText: "\(details.index)",
            valueNumber: Double(details.index),
            categoryTitle: details.standard,
            summary: details.summary,
            colorStops: defaultStops
        )
    }
}
