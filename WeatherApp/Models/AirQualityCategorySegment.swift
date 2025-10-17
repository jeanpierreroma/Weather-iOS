//
//  AirQualityCategorySegment.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 15.10.2025.
//


import SwiftUI

struct AirQualityCategorySegment: Identifiable {
    let identifier = UUID()
    let label: String
    let range: ClosedRange<Double>
    let color: Color
    var id: UUID { identifier }
}