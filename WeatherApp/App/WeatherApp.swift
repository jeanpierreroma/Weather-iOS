//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    @State private var container = AppContainer(config: .dev)
    @State private var prefsStore = UserPreferencesStore(repo: UserDefaultsUserPreferencesRepository())
    
    let uviProps: UVIDetailsProps = UVIDetailsPresenter.props()
    let humidityProps: HumidityDetailsProps = HumidityDetailsPresenter.props()
    let visibilityProps: VisibilityDetailsProps = VisibilityDetailsPresenter.props()
    let pressureProps: PressureDetailsProps = PressureDetailsPresenter.props()
    
    var body: some Scene {
        WindowGroup {
//            RootView()
//                .environment(\.appContainer, container)
//                .environment(\.userPreferences, prefsStore)
            
            MetricDetailsView(
                uviProps: uviProps,
                humidityProps: humidityProps,
                visibilityProps: visibilityProps,
                pressureProps: pressureProps
            )
        }
    }
}





