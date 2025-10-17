//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

@main
struct WeatherApp: App {
    let viewModel = ForecastViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ForecastView(viewModel: viewModel)
            WeatherDetailsView()
        }
    }
}
