//
//  MoonDetails.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import Foundation

struct MoonDetails: Sendable {
    /// Display name for the current moon phase (e.g. "Waxing Crescent").
    let phaseName: String
    /// Moon illumination in percents (0...100).
    let illuminationPercent: Double
    /// Fraction describing current progress of the lunar cycle (0 - new moon, 0.5 - full moon, 1 - new moon).
    let phaseFraction: Double
    /// Next moonset date, if available.
    let moonset: Date?
    /// Number of days until the next full moon, if it can be calculated.
    let daysUntilFullMoon: Int?

    init(
        phaseName: String,
        illuminationPercent: Double,
        phaseFraction: Double,
        moonset: Date?,
        daysUntilFullMoon: Int?
    ) {
        self.phaseName = phaseName
        self.illuminationPercent = illuminationPercent
        self.phaseFraction = phaseFraction
        self.moonset = moonset
        self.daysUntilFullMoon = daysUntilFullMoon
    }
}
