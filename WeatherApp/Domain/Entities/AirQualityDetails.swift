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

//enum AirQualityStandard: CaseIterable, Sendable {
//    case good, satisfactory, moderate, poor, veryPoor, severe
//    
//    var range: ClosedRange<Int> {
//        switch self {
//        case .good:        return 0...50
//        case .satisfactory:return 51...100
//        case .moderate:    return 101...200
//        case .poor:        return 201...300
//        case .veryPoor:    return 301...400
//        case .severe:      return 401...Int.max
//        }
//    }
//    
//    var title: String {
//        switch self {
//        case .good:        return "Good"
//        case .satisfactory:return "Satisfactory"
//        case .moderate:    return "Moderate"
//        case .poor:        return "Poor"
//        case .veryPoor:    return "Very Poor"
//        case .severe:      return "Severe"
//        }
//    }
//    
//    static func from(index: Int) -> Self {
//        Self.allCases.first(where: { $0.range.contains(index.clamped(to: 0...500)) }) ?? .severe
//    }
//}
