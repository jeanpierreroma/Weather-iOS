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
    func makeWeatherOverviewViewModel() -> WeatherOverviewViewModel {
        let hourly = (0..<12).map { i in
            HourForecastPoint(
                date: Calendar.current.date(byAdding: .hour, value: i, to: .now)!,
                celsius: Double(12 + i/2),
                symbol: ["cloud.sun", "cloud.rain", "sun.max"].randomElement()!
            )
        }
        
        return WeatherOverviewViewModel(hourly: hourly, fetchDailyForecastUseCase: fetchDailyForecastUseCase)
    }
}
