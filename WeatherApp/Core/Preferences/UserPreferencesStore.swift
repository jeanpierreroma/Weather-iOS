//
//  UserPreferencesStore.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class UserPreferencesStore {
    private(set) var prefs: UserPreferences = .init()

    @ObservationIgnored
    private let repo: UserPreferencesRepository

    @ObservationIgnored
    private var task: Task<Void, Never>?

    init(repo: UserPreferencesRepository) {
        self.repo = repo

        task = Task { [weak self] in
            guard let self else { return }

            // 1) початкове завантаження
            if let loaded = try? await repo.load() {
                self.prefs = loaded
            }

            // 2) підписка на оновлення
            let stream = await repo.observe()
            for await next in stream {
                self.prefs = next
            }
        }
    }

    deinit { task?.cancel() }

    // MARK: - Mutations
    func setTemperatureUnit(_ unit: TemperatureUnit) async {
        try? await repo.setTemperatureUnit(unit)
    }

    func setWindSpeedUnit(_ unit: WindSpeedUnit) async {
        try? await repo.setWindSpeedUnit(unit)
    }

    func setPrecipitationUnit(_ unit: PrecipitationUnit) async {
        try? await repo.setPrecipitationUnit(unit)
    }

    func setTimeUnit(_ unit: TimeUnit) async {
        try? await repo.setTimeUnit(unit)
    }
}

