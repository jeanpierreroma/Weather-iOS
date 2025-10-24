//
//  UserPreferences.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

public struct UserPreferences: Codable, Equatable, Sendable {
    public var temperatureUnit: TemperatureUnit
    public var windSpeedUnit: WindSpeedUnit
    public var precipitationUnit: PrecipitationUnit
    public var timeUnit: TimeUnit

    public init(
        temperatureUnit: TemperatureUnit = .celsius,
        windSpeedUnit: WindSpeedUnit = .kilometersPerHour,
        precipitationUnit: PrecipitationUnit = .millimeters,
        timeUnit: TimeUnit = .iso8601
    ) {
        self.temperatureUnit = temperatureUnit
        self.windSpeedUnit = windSpeedUnit
        self.precipitationUnit = precipitationUnit
        self.timeUnit = timeUnit
    }
}
