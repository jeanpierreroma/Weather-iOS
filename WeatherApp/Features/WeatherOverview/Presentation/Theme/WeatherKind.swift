//
//  WeatherKind.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//


import SwiftUI

enum WeatherKind: String, CaseIterable, Hashable, Sendable {
    case clear, partlyCloudy, cloudy, fog
    case drizzle, rain, heavyRain, thunderstorm
    case snow, sleet, hail, wind
}