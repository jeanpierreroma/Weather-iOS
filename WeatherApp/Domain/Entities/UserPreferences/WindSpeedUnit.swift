//
//  WindSpeedUnit.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation

public enum WindSpeedUnit: String, Codable, CaseIterable, Sendable {
    case kilometersPerHour = "kph"
    case metersPerSecond   = "mps"
    case milesPerHour      = "mph"
}

extension WindSpeedUnit {
    var foundationUnit: UnitSpeed {
        switch self {
        case .kilometersPerHour: return .kilometersPerHour
        case .metersPerSecond:   return .metersPerSecond
        case .milesPerHour:      return .milesPerHour
        }
    }
}
