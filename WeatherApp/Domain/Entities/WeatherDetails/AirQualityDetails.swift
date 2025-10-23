//
//  AirQualityDetails.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import Foundation

struct AirQualityDetails: Sendable {
    let index: Int
    let standard: String
    let summary: String
    
    init(index: Int, standard: String, summary: String) {
        self.index = index.clamped(to: 0...500)
        self.standard = standard
        self.summary = summary
    }
}
