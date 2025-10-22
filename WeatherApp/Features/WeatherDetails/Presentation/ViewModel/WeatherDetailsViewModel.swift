//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import Foundation
import Observation

@MainActor
@Observable
final class WeatherDetailsViewModel {
    private(set) var details: WeatherDetails?
    private let fetchDailyForecastUseCase: FetchDailyForecast
    
    init(fetchDailyForecastUseCase: FetchDailyForecast) {
        self.fetchDailyForecastUseCase = fetchDailyForecastUseCase
    }
    
    func loadData() async {
//        switch await fetchDailyForecastUseCase.callAsFunction() {
//        case .success(let details):
////            self.details = details
//            self.details = makeMockData()
//        case .failure(let failure):
//            print(failure.message)
//        }
        
        self.details = makeMockData()
    }
    
    private func makeMockData() -> WeatherDetails {
        .init(
            aqi: .init(index: 50, summary: "Air quality index is \(50), which is similar to yesterday at about this time."),
            feelsLike: .init(temperature: 21, summary: "Similar to the actual temperature."),
            uvDetails: .init(index: 0, summary: ""),
            windDetails: .init(windSpeedMps: 18, gustSpeedMps: 6, directionDegrees: 315),
            sunDetails: .init(
                sunrise: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: .now)!,
                sunset: Calendar.current.date(bySettingHour: 18, minute: 16, second: 0, of: .now)!
            ),
            precipitationDetails: .init(precipLast24hMm: 5, summary: "<1 mm expected in next 24h"),
            visibilityDetails: .init(visibilityKm: 16, summary: "Perfectly clear view."),
            humidityDetails: .init(humidityPercent: 89, summary: "The dew point is 20° right now."),
            pressureDetails: .init(pressureHpa: 1024, summary: "")
        )
    }
}
