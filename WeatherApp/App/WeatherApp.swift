//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    @State private var temperatureUnit = TemperatureDisplayUnit.celsius
    @State private var pressureUnit = PressureDisplayUnit.hPa
    @State private var windSpeedUnit = UnitSpeed.metersPerSecond
        
    @State private var container = AppContainer(config: .dev)
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.temperatureUnit, temperatureUnit)
                .environment(\.pressureUnit, pressureUnit)
                .environment(\.windSpeedUnit, windSpeedUnit)
                .environment(\.appContainer, container)
        }
    }
}
