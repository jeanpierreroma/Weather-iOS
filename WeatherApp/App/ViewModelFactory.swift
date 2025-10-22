//
//  ViewModelFactory.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 09.10.2025.
//

import Foundation

protocol ViewModelFactory {
    @MainActor
    func makeWeatherDetailsVM() -> WeatherDetailsViewModel
}
