//
//  UVIndex.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import Foundation

struct UVDetails {
    let index: Int
    let standard: UVStandard
    let summary: String
    
    
}

enum UVStandard: CaseIterable, Sendable {
    case low, moderate, high, veryHigh, extreme
    
    var range: ClosedRange<Int> {
        switch self {
        case .low:          return 0...2
        case .moderate:     return 3...5
        case .high:         return 6...7
        case .veryHigh:     return 8...10
        case .extreme:      return 11...Int.max
        }
    }
    
    var title: String {
        switch self {
        case .low:          return "Low"
        case .moderate:     return "Moderate"
        case .high:         return "High"
        case .veryHigh:     return "Very High"
        case .extreme:      return "Extreme"
        }
    }
    
    static func from(index: Int) -> Self {
        Self.allCases.first(where: { $0.range.contains(index.clamped(to: 0...11)) }) ?? .extreme
    }
}
