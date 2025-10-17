//
//  TimeFormatters.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

enum TimeFormatters {
    static func shortTime(calendar: Calendar, locale: Locale) -> DateFormatter {
        let f = DateFormatter()
        f.locale = locale
        f.calendar = calendar
        f.timeZone = calendar.timeZone
        f.dateStyle = .none
        f.timeStyle = .short
        return f
    }
}
