//
//  ForecastItemPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import Foundation

enum HourForecastItemPresenter {
    static func props(
        date: Date,
        celsius: Double,
        symbol: String,
        tempUnit: TemperatureUnit,
        weatherProbability: Int? = nil,
        calendar: Calendar,
        locale: Locale
    ) -> HourForecastItemProps {
        let label = makeLabel(for: date, calendar: calendar, locale: locale)
        let temp = TemperatureFormatter.format(celsius: celsius, to: tempUnit)
        let probabilityText = weatherProbability.map(String.init(describing:)) ?? nil

        return HourForecastItemProps(
            labelText: label,
            weatherSymbolName: symbol,
            weatherProbabilityText: probabilityText,
            temperatureText: temp
        )
    }

    private static func makeLabel(for date: Date, calendar: Calendar, locale: Locale) -> String {
        let rounded = TimeFormatters.roundToHour(date, calendar: calendar, mode: .floor)
        let f = TimeFormatters.shortTime(calendar: calendar, locale: locale, hoursOnly: true)
        return f.string(from: rounded)
    }
}
