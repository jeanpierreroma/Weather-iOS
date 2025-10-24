//
//  TimeFormatters.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

enum TimeFormatters {
    enum HourRounding {
        case none      // без змін
        case floor     // донизу (12:12 -> 12:00, 12:59 -> 12:00)
        case ceil      // вгору  (12:01 -> 13:00)
        case nearest   // до найближчої (>=30 — вгору) (12:12 -> 12:00, 12:35 -> 13:00)
    }
    
    static func shortTime(
        calendar: Calendar,
        locale: Locale,
        hoursOnly: Bool = false
    ) -> DateFormatter {
        let f = DateFormatter()
        f.locale = locale
        f.calendar = calendar
        f.timeZone = calendar.timeZone

        if hoursOnly {
            let pattern = DateFormatter.dateFormat(fromTemplate: "j", options: 0, locale: locale) ?? "HH"
            let hourOnly = pattern.replacingOccurrences(of: "a", with: "").trimmingCharacters(in: .whitespaces)
            f.dateFormat = hourOnly.isEmpty ? "HH" : hourOnly
        } else {
            f.dateStyle = .none
            f.timeStyle = .short
        }
        return f
    }
    
    static func roundToHour(
        _ date: Date,
        calendar: Calendar,
        mode: HourRounding = .nearest
    ) -> Date {
        guard mode != .none else { return date }

        let comps = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let base = calendar.date(from: DateComponents(
            timeZone: calendar.timeZone,
            year: comps.year, month: comps.month, day: comps.day,
            hour: comps.hour, minute: 0, second: 0
        )) ?? date

        switch mode {
        case .none:
            return date
        case .floor:
            return base
        case .ceil:
            if (comps.minute ?? 0) > 0 || (comps.second ?? 0) > 0 {
                return calendar.date(byAdding: .hour, value: 1, to: base) ?? base
            }
            return base
        case .nearest:
            if (comps.minute ?? 0) >= 30 {
                return calendar.date(byAdding: .hour, value: 1, to: base) ?? base
            } else {
                return base
            }
        }
    }
}
