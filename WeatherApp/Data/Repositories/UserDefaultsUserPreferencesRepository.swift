//
//  UserDefaultsUserPreferencesRepository.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation

actor UserDefaultsUserPreferencesRepository: UserPreferencesRepository {
    private let defaults: UserDefaults
    private let key = "user_preferences"
    
    private var continuations: [UUID: AsyncStream<UserPreferences>.Continuation] = [:]

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() throws -> UserPreferences {
        if let data = defaults.data(forKey: key),
           let prefs = try? JSONDecoder().decode(UserPreferences.self, from: data) {
            return prefs
        }
        
        return UserPreferences()
    }

    func observe() -> AsyncStream<UserPreferences> {
        let id = UUID()
        return AsyncStream { cont in
            continuations[id] = cont

            cont.onTermination = { [weak self] _ in
                Task { await self?.removeContinuation(id) }
            }

            if let current = try? self.load() { cont.yield(current) }
        }
    }

    func setTemperatureUnit(_ unit: TemperatureUnit) throws {
        try update { $0.temperatureUnit = unit }
    }

    func setWindSpeedUnit(_ unit: WindSpeedUnit) throws {
        try update { $0.windSpeedUnit = unit }
    }

    func setPrecipitationUnit(_ unit: PrecipitationUnit) throws {
        try update { $0.precipitationUnit = unit }
    }

    func setTimeUnit(_ unit: TimeUnit) throws {
        try update { $0.timeUnit = unit }
    }
    
    private func save(_ prefs: UserPreferences) throws {
        let data = try JSONEncoder().encode(prefs)
        defaults.set(data, forKey: key)
        notify(prefs)
    }
    
    private func removeContinuation(_ id: UUID) {
        continuations[id] = nil
    }
    
    private func notify(_ prefs: UserPreferences) {
        for (_, c) in continuations { c.yield(prefs) }
    }
    
    private func update(_ mutate: (inout UserPreferences) -> Void) throws {
        var p = try load()
        mutate(&p)
        try save(p)
    }
}
