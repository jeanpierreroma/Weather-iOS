//
//  LocationWeatherCardProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//


import SwiftUI

struct LocationWeatherCardProps: Identifiable, Hashable {
    let id: UUID = .init()
    let displayName: String
    let isMyLocation: Bool
    let isHome: Bool
    let localTime: Date
    let condition: String
    let temperature: Int
    let high: Int
    let low: Int

    // formatting
    var temperatureText: String { "\(temperature)°" }
    var highText: String { "\(high)°" }
    var lowText: String { "\(low)°" }
}