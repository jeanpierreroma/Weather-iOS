//
//  ConditionTab.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import Foundation

enum ConditionTab: String, CaseIterable, Identifiable {
    case uvi, humidity, visibility, pressure
    var id: Self { self }

    var title: String {
        switch self {
        case .uvi:        return "UVI"
        case .humidity:   return "Humidity"
        case .visibility: return "Visibility"
        case .pressure:   return "Pressure"
        }
    }

    var icon: String {
        switch self {
        case .uvi:        return "sun.max"
        case .humidity:   return "drop"
        case .visibility: return "eye"
        case .pressure:   return "gauge"
        }
    }
}
