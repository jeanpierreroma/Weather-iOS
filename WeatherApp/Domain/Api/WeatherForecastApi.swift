//
//  WeatherForecastApi.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

protocol WeatherForecastApi {
    func fetchWeatherForecast(latitude: Double, longitude: Double) async -> Result<DailyForecastDto, NetworkFailure>
}
