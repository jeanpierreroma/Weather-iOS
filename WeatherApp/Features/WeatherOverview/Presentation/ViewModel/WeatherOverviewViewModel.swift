//
//  WeatherOverviewViewModel.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import Observation
import UIKit

@MainActor
@Observable
final class WeatherOverviewViewModel {
    var hourly: [HourForecastPoint]
    private(set) var details: WeatherDetails?

    init(hourly: [HourForecastPoint]) {
        self.hourly = hourly
    }
    
    func loadData() async {
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
