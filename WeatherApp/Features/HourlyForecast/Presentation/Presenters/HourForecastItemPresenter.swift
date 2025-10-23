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
        tempUnit: TemperatureDisplayUnit,
        calendar: Calendar,
        locale: Locale
    ) -> HourForecastItemProps {
        let label = makeLabel(for: date, calendar: calendar, locale: locale)
        let temp = TemperatureFormatter.format(celsius: celsius, to: tempUnit)

        return HourForecastItemProps(
            labelText: label,
            symbolName: symbol,
            temperatureText: temp
        )
    }

    private static func makeLabel(for date: Date, calendar: Calendar, locale: Locale) -> String {
        let df = TimeFormatters.shortTime(calendar: calendar, locale: locale)
        return df.string(from: date)
    }
}
