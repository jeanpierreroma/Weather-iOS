//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

protocol WeatherRepository {
    func fetchWetherDetails(latitude: Double, longitude: Double) async -> Result<DailyForecastDto, RepositoryFailure>
}
