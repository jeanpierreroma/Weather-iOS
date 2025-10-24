//
//  UserPreferencesKey.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//


import SwiftUI

actor InMemoryUserPreferencesRepository: UserPreferencesRepository {
    private var current = UserPreferences()
    private var continuations: [UUID: AsyncStream<UserPreferences>.Continuation] = [:]

    func load() throws -> UserPreferences { current }

    func observe() -> AsyncStream<UserPreferences> {
        let id = UUID()
        return AsyncStream { c in
            continuations[id] = c
            c.onTermination = { [weak self] _ in
                Task { await self?.remove(id) }
            }
            c.yield(current)
        }
    }

    private func remove(_ id: UUID) { continuations[id] = nil }
    private func notify() { for (_, c) in continuations { c.yield(current) } }

    func setTemperatureUnit(_ unit: TemperatureUnit) throws {
        current.temperatureUnit = unit; notify()
    }
    func setWindSpeedUnit(_ unit: WindSpeedUnit) throws {
        current.windSpeedUnit = unit; notify()
    }
    func setPrecipitationUnit(_ unit: PrecipitationUnit) throws {
        current.precipitationUnit = unit; notify()
    }
    func setTimeUnit(_ unit: TimeUnit) throws {
        current.timeUnit = unit; notify()
    }
}
