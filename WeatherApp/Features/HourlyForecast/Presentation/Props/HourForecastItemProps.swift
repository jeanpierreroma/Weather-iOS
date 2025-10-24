//
//  ForecastItemProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import Foundation

public struct HourForecastItemProps: Sendable, Equatable {
    public let labelText: String
    public let weatherSymbolName: String
    public let weatherProbabilityText: String?
    public let temperatureText: String
}
