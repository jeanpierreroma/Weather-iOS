//
//  TemperatureFormatter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import Foundation

enum TemperatureFormatter {
    static func format(celsius: Double, to unit: TemperatureUnit, fractionDigits: Int = 0, locale: Locale = .current) -> String {
        let raw: Double = {
            switch unit {
            case .celsius:    return celsius
            case .fahrenheit: return celsius * 9.0 / 5.0 + 32.0
            }
        }()
        
        let nf = NumberFormatter()
        nf.locale = locale
        nf.minimumFractionDigits = fractionDigits
        nf.maximumFractionDigits = fractionDigits
        nf.minimumIntegerDigits = 1

        let text = nf.string(from: NSNumber(value: raw))
            ?? String(format: "%.\(fractionDigits)f", raw)

        return "\(text)°"
    }
}
