//
//  FeelsLikePresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

enum FeelsLikePresenter {
    static func props(from details: FeelsLikeDetails, unit: TemperatureUnit) -> FeelsLikeProps {
        .init(
            apparentTemperatureText: TemperatureFormatter.format(celsius: details.apparentTemperature, to: unit),
            actualTemperatureText: TemperatureFormatter.format(celsius: details.actualTemperature, to: unit),
            summary: details.summary,
            apparentTemperatureValue: details.apparentTemperature,
            actualTemperatureValue: details.actualTemperature
        )
    }
}

