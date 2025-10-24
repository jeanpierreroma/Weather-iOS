//
//  FeelsLikePresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

enum FeelsLikePresenter {
    static func props(from details: FeelsLikeDetails, unit: TemperatureUnit) -> FeelsLikeProps {
        .init(
            temperatureText: TemperatureFormatter.format(celsius: details.temperature, to: unit),
            summary: details.summary
        )
    }
}

