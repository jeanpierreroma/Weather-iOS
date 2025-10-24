//
//  WeatherColors.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import SwiftUI

enum WeatherColors {
    // Мапа: ПОГОДА (день/ніч) -> базовий колір блока
    static let map: [WeatherThemeKey: Color] = [
        // ☀️ Clear
        .init(kind: .clear, isNight: false): Color(hex: "#7BC6FF"),
        .init(kind: .clear, isNight: true ): Color(hex: "#1F3B73"),

        // ⛅️ Partly Cloudy
        .init(kind: .partlyCloudy, isNight: false): Color(hex: "#9BC9FF"),
        .init(kind: .partlyCloudy, isNight: true ): Color(hex: "#2A5298"),

        // ☁️ Cloudy
        .init(kind: .cloudy, isNight: false): Color(hex: "#AAB6C1"),
        .init(kind: .cloudy, isNight: true ): Color(hex: "#46515B"),

        // 🌫 Fog
        .init(kind: .fog, isNight: false): Color(hex: "#C7D1DA"),
        .init(kind: .fog, isNight: true ): Color(hex: "#58636C"),

        // 🌦 Drizzle
        .init(kind: .drizzle, isNight: false): Color(hex: "#92A6B5"),
        .init(kind: .drizzle, isNight: true ): Color(hex: "#3E4A57"),

        // 🌧 Rain
        .init(kind: .rain, isNight: false): Color(hex: "#5C7FA3"),
        .init(kind: .rain, isNight: true ): Color(hex: "#2F3E55"),

        // ☔️ Heavy Rain
        .init(kind: .heavyRain, isNight: false): Color(hex: "#465D79"),
        .init(kind: .heavyRain, isNight: true ): Color(hex: "#223047"),

        // ⛈ Thunderstorm
        .init(kind: .thunderstorm, isNight: false): Color(hex: "#4A4F86"),
        .init(kind: .thunderstorm, isNight: true ): Color(hex: "#312B63"),

        // ❄️ Snow
        .init(kind: .snow, isNight: false): Color(hex: "#CFE7FF"),
        .init(kind: .snow, isNight: true ): Color(hex: "#6E8193"),

        // 🌨 Sleet / Hail
        .init(kind: .sleet, isNight: false): Color(hex: "#BFD3E2"),
        .init(kind: .sleet, isNight: true ): Color(hex: "#4A5E73"),
        .init(kind: .hail,  isNight: false): Color(hex: "#BFD3E2"),
        .init(kind: .hail,  isNight: true ): Color(hex: "#3F5670"),

        // 🌬 Wind
        .init(kind: .wind, isNight: false): Color(hex: "#8CCFD1"),
        .init(kind: .wind, isNight: true ): Color(hex: "#2F5F71"),
    ]

    static func color(for kind: WeatherKind, isNight: Bool) -> Color {
        map[.init(kind: kind, isNight: isNight)]
        ?? map[.init(kind: .cloudy, isNight: isNight)]
        ?? .indigo
    }

    // Якщо зручно — як і з градієнтами, за SF Symbol:
    static func color(forSymbol symbol: String, isNight: Bool) -> Color {
        let kind = WeatherSymbolMapper.kind(for: symbol)
        return color(for: kind, isNight: isNight)
    }
}
