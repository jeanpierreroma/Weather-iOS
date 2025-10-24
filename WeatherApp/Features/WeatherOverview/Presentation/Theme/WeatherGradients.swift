//
//  WeatherGradients.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//


import SwiftUI

enum WeatherGradients {
    // 4) Словник: ПОГОДА (день/ніч) -> градієнт
    static let map: [WeatherThemeKey: GradientSpec] = [
        // ☀️ Clear
        .init(kind: .clear, isNight: false): .init(colors: [Color(hex:"#a1c4fd"), Color(hex:"#c2e9fb")]),
        .init(kind: .clear, isNight: true ): .init(colors: [Color(hex:"#0f2027"), Color(hex:"#203A43"), Color(hex:"#2C5364")]),

        // ⛅️ Partly Cloudy
        .init(kind: .partlyCloudy, isNight: false): .init(colors: [Color(hex:"#8EC5FC"), Color(hex:"#E0C3FC")]),
        .init(kind: .partlyCloudy, isNight: true ): .init(colors: [Color(hex:"#1E3C72"), Color(hex:"#2A5298")]),

        // ☁️ Cloudy / Overcast
        .init(kind: .cloudy, isNight: false): .init(colors: [Color(hex:"#D7D2CC"), Color(hex:"#304352")]),
        .init(kind: .cloudy, isNight: true ): .init(colors: [Color(hex:"#232526"), Color(hex:"#414345")]),

        // 🌫 Fog / Haze
        .init(kind: .fog, isNight: false): .init(colors: [Color(hex:"#e0eafc"), Color(hex:"#cfdef3")]),
        .init(kind: .fog, isNight: true ): .init(colors: [Color(hex:"#616E72"), Color(hex:"#3A3F44")]),

        // 🌦 Drizzle
        .init(kind: .drizzle, isNight: false): .init(colors: [Color(hex:"#cfd9df"), Color(hex:"#e2ebf0")]),
        .init(kind: .drizzle, isNight: true ): .init(colors: [Color(hex:"#2b5876"), Color(hex:"#4e4376")]),

        // 🌧 Rain
        .init(kind: .rain, isNight: false): .init(colors: [Color(hex:"#4b79a1"), Color(hex:"#283e51")]),
        .init(kind: .rain, isNight: true ): .init(colors: [Color(hex:"#1F1C2C"), Color(hex:"#928DAB")]),

        // ☔️ Heavy Rain
        .init(kind: .heavyRain, isNight: false): .init(colors: [Color(hex:"#485563"), Color(hex:"#29323c")]),
        .init(kind: .heavyRain, isNight: true ): .init(colors: [Color(hex:"#0f2027"), Color(hex:"#203A43")]),

        // ⛈ Thunderstorm
        .init(kind: .thunderstorm, isNight: false): .init(colors: [Color(hex:"#141E30"), Color(hex:"#243B55")]),
        .init(kind: .thunderstorm, isNight: true ): .init(colors: [Color(hex:"#0f0c29"), Color(hex:"#302b63"), Color(hex:"#24243e")]),

        // ❄️ Snow
        .init(kind: .snow, isNight: false): .init(colors: [Color(hex:"#E6F0FF"), Color(hex:"#A8C0FF")]),
        .init(kind: .snow, isNight: true ): .init(colors: [Color(hex:"#536976"), Color(hex:"#292E49")]),

        // 🌨 Sleet / Hail (холодніші відтінки)
        .init(kind: .sleet, isNight: false): .init(colors: [Color(hex:"#dfe9f3"), Color(hex:"#ffffff")]),
        .init(kind: .sleet, isNight: true ): .init(colors: [Color(hex:"#4b6cb7"), Color(hex:"#182848")]),
        .init(kind: .hail,  isNight: false): .init(colors: [Color(hex:"#d7e1ec"), Color(hex:"#ffffff")]),
        .init(kind: .hail,  isNight: true ): .init(colors: [Color(hex:"#2b5876"), Color(hex:"#4e4376")]),

        // 🌬 Windy
        .init(kind: .wind, isNight: false): .init(colors: [Color(hex:"#74ebd5"), Color(hex:"#ACB6E5")]),
        .init(kind: .wind, isNight: true ): .init(colors: [Color(hex:"#000046"), Color(hex:"#1CB5E0")]),
    ]
    
    // 5) Отримати градієнт по типу
    static func gradient(for kind: WeatherKind, isNight: Bool) -> LinearGradient {
        let key = WeatherThemeKey(kind: kind, isNight: isNight)
        let spec = map[key]
            ?? map[WeatherThemeKey(kind: .cloudy, isNight: isNight)]
            ?? .init(colors: [.indigo, .purple, .pink])

        return LinearGradient(colors: spec.colors, startPoint: .top, endPoint: .bottom)
    }

    // 6) Зручний хелпер: беремо SF Symbol і вираховуємо WeatherKind
    static func gradient(forSymbol symbol: String, isNight: Bool) -> LinearGradient {
        gradient(for: WeatherSymbolMapper.kind(for: symbol), isNight: isNight)
    }

}