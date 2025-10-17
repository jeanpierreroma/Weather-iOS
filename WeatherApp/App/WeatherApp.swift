//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

@main
struct WeatherApp: App {
//    let viewModel = ForecastViewModel()
    @State private var temperatureUnit = TemperatureDisplayUnit.celsius
    @State private var pressureUnit = PressureDisplayUnit.hPa
    @State private var windSpeedUnit = UnitSpeed.metersPerSecond
    
    var body: some Scene {
        WindowGroup {
//            ForecastView(viewModel: viewModel)
            WeatherDetailsView()
                .environment(\.temperatureUnit, temperatureUnit)
                .environment(\.pressureUnit, pressureUnit)
                .environment(\.windSpeedUnit, windSpeedUnit)
        }
    }
}
