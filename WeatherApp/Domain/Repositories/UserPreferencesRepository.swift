//
//  UserPreferencesRepository.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation

protocol UserPreferencesRepository: Actor {
    func load() throws -> UserPreferences
    
    func setTemperatureUnit(_ unit: TemperatureUnit) throws
    func setWindSpeedUnit(_ unit: WindSpeedUnit) throws
    func setPrecipitationUnit(_ unit: PrecipitationUnit) throws
    func setTimeUnit(_ unit: TimeUnit) throws

    func observe() -> AsyncStream<UserPreferences>
}
