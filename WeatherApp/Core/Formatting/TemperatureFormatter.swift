//
//  TemperatureFormatter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//


enum TemperatureFormatter {
    static func format(celsius: Double, to unit: TemperatureDisplayUnit) -> String {
        let value: Double = switch unit {
        case .celsius: celsius
        case .fahrenheit: (Double(celsius) * 9.0/5.0 + 32.0).rounded()
        }
        return "\(value)°\(unit.suffix)"
    }
}
