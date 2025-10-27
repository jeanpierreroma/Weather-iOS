//
//  MoonPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import Foundation

enum MoonPresenter {
    static func props(
        from details: MoonDetails,
        calendar: Calendar = .autoupdatingCurrent,
        locale: Locale = .current
    ) -> WaxingCrescentProps {
        let illuminationText = Self.illuminationFormatter(locale: locale)
            .string(from: NSNumber(value: details.illuminationPercent))
            ?? "\(Int(details.illuminationPercent.rounded()))%"

        let timeFormatter = TimeFormatters.shortTime(calendar: calendar, locale: locale)
        let moonsetText: String
        if let moonset = details.moonset {
            moonsetText = timeFormatter.string(from: moonset)
        } else {
            moonsetText = Self.placeholder(locale: locale)
        }

        let nextFullMoonText = Self.nextFullMoonText(days: details.daysUntilFullMoon, locale: locale)

        return WaxingCrescentProps(
            title: Self.displayName(for: details.phaseName, locale: locale),
            symbolName: Self.symbolName(for: details.phaseName),
            illuminationText: illuminationText,
            moonsetText: moonsetText,
            nextFullMoonText: nextFullMoonText,
            currentMoonPicture: Self.moonImageURL(for: details.phaseFraction)
        )
    }
}

private extension MoonPresenter {
    static func displayName(for rawName: String, locale: Locale) -> String {
        let sanitized = rawName
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !sanitized.isEmpty else {
            return NSLocalizedString("Moon", comment: "Moon phase title fallback")
        }

        return sanitized.capitalized(with: locale)
    }

    static func symbolName(for phaseName: String) -> String {
        let lookup = [
            "new moon": "moonphase.new.moon",
            "waxing crescent": "moonphase.waxing.crescent",
            "first quarter": "moonphase.first.quarter",
            "waxing gibbous": "moonphase.waxing.gibbous",
            "full moon": "moonphase.full.moon",
            "waning gibbous": "moonphase.waning.gibbous",
            "last quarter": "moonphase.last.quarter",
            "waning crescent": "moonphase.waning.crescent"
        ]

        let key = phaseName.lowercased()
        return lookup[key] ?? "moon"
    }

    static func moonImageURL(for fraction: Double) -> URL {
        // NASA SVS: https://svs.gsfc.nasa.gov/5415#media_group_419784
        let base = 7153
        let upper = 7176
        let clampedFraction = fraction.clamped(to: 0...1)
        let steps = upper - base
        let index = Int((Double(steps) * clampedFraction).rounded())
        let imageNumber = min(base + index, upper)
        let urlString = String(format: "https://svs.gsfc.nasa.gov/vis/a000000/a005400/a005415/frames/730x730_1x1_30p/moon.%04d.jpg", imageNumber)
        return URL(string: urlString)!
    }

    static func nextFullMoonText(days: Int?, locale: Locale) -> String {
        guard let days = days, days >= 0 else {
            return placeholder(locale: locale)
        }

        switch days {
        case 0:
            return NSLocalizedString("Today", comment: "Next full moon happens today")
        case 1:
            return NSLocalizedString("Tomorrow", comment: "Next full moon happens tomorrow")
        default:
            let format = NSLocalizedString("%d days", comment: "Number of days until next full moon")
            return String(format: format, days)
        }
    }

    static func placeholder(locale: Locale) -> String {
        NSLocalizedString("—", comment: "Unavailable value placeholder")
    }

    static func illuminationFormatter(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.multiplier = 1
        return formatter
    }
}
