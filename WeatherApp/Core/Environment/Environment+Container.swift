//
//  Environment+Container.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

@MainActor
private struct AppContainerKey: @preconcurrency EnvironmentKey {
    static let defaultValue: AppContainer = AppContainer(config: .dev)
}

@MainActor
private struct UserPreferencesKey: @preconcurrency EnvironmentKey {
    static let defaultValue: UserPreferencesStore = {
        
        #if DEBUG
        let repo: UserPreferencesRepository = InMemoryUserPreferencesRepository()
        #else
        let repo: UserPreferencesRepository = UserDefaultsUserPreferencesRepository()
        #endif

        return UserPreferencesStore(repo: repo)
    }()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
    
    var userPreferences: UserPreferencesStore {
        get { self[UserPreferencesKey.self] }
        set { self[UserPreferencesKey.self] = newValue }
    }
}
