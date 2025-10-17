//
//  AirQualityPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

enum AirQualityPresenter {
    static var defaultStops: [(Double, Color)] {
        [
            (0,   Color(hex: "#2E7D32")),
            (50,  Color(hex: "#66BB6A")),
            (100, Color(hex: "#FFEB3B")),
            (200, Color(hex: "#FFA726")),
            (300, Color(hex: "#EF5350")),
            (400, Color(hex: "#6D1B1B")),
            (500, Color(hex: "#6D1B1B"))
        ].map { (Double($0.0), $0.1) }
    }
    
    static func props(from details: AirQualityDetails) -> AirQualityProps {
        .init(
            valueText: "\(details.index)",
            valueNumber: Double(details.index),
            categoryTitle: details.standard.title,
            summary: details.summary,
            colorStops: defaultStops
        )
    }
}




