//
//  DaysForecastItemPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 22.10.2025.
//

import Foundation

enum DaysForecastItemPresenter {
    static func props(
        date: Date,
        lowestCelsius: Double,
        highestCelsius: Double,
        symbol: String,
        tempUnit: TemperatureUnit,
        calendar: Calendar,
        locale: Locale
    ) -> DaysForecastItemProps {
        let dayLabel = makeDayOfWeekLabel(for: date, calendar: calendar, locale: locale)
        let low  = TemperatureFormatter.format(celsius: lowestCelsius,  to: tempUnit)
        let high = TemperatureFormatter.format(celsius: highestCelsius, to: tempUnit)

        return DaysForecastItemProps(
            dayOfWeek: dayLabel,
            weatherIcon: symbol,
            lowestTemperatureText: low,
            highestTemperatureText: high
        )
    }

    private static func makeDayOfWeekLabel(for date: Date, calendar: Calendar, locale: Locale) -> String {
        let todayStart = calendar.startOfDay(for: Date())
        let dayStart   = calendar.startOfDay(for: date)
        let dayDiff = calendar.dateComponents([.day], from: todayStart, to: dayStart).day ?? 0

        // Для Today/Tomorrow/Yesterday використовуємо DateFormatter з
        // doesRelativeDateFormatting, щоб отримати локалізовані слова.
        func relativeName(for d: Date) -> String {
            let df = DateFormatter()
            df.locale = locale
            df.calendar = calendar
            df.timeStyle = .none
            df.dateStyle = .medium
            df.doesRelativeDateFormatting = true
            
            return df.string(from: d)
        }

        switch dayDiff {
        case 0:
            return relativeName(for: todayStart)
        default:
            let df = DateFormatter()
            df.locale = locale
            df.calendar = calendar
            df.setLocalizedDateFormatFromTemplate("EEE")    // коротка назва дня
            return df.string(from: date)
        }
    }
}
