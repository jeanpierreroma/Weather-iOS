//
//  SunPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

enum SunPresenter {
    static func props(
        from details: SunDetails,
        now: Date,
        calendar: Calendar = .autoupdatingCurrent,
        locale: Locale = .current
    ) -> SunProps {

        let df = TimeFormatters.shortTime(calendar: calendar, locale: locale)

        let sunriseText = df.string(from: details.sunrise)
        let sunsetText  = df.string(from: details.sunset)

        let dayStart = calendar.startOfDay(for: now)
        let nextDayStart = calendar.date(byAdding: .day, value: 1, to: dayStart)!
        let dayLen = nextDayStart.timeIntervalSince(dayStart)
        let elapsed = now.timeIntervalSince(dayStart)
        let frac = max(0, min(1, elapsed / dayLen))

        return SunProps(
            sunriseText: sunriseText,
            sunsetText: sunsetText,
            dayFraction: CGFloat(frac)
        )
    }
}


