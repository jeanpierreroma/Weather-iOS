//
//  DefaultViewModelFactory.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 09.10.2025.
//


import Foundation

final class DefaultViewModelFactory: ViewModelFactory {
    private let fetchDailyForecastUseCase: FetchDailyForecast

    init(fetchDailyForecastUseCase: FetchDailyForecast) {
        self.fetchDailyForecastUseCase = fetchDailyForecastUseCase
    }

    @MainActor
    func makeWeatherDetailsVM() -> WeatherDetailsViewModel {
        WeatherDetailsViewModel(fetchDailyForecastUseCase: fetchDailyForecastUseCase)
    }
}
