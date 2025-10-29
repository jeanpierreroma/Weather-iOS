//
//  MoonDetails.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import Foundation

struct MoonDetails: Sendable {
    let phaseName: String
    let moonUrl: String
    let illuminationPercent: Double
    let moodSet: Date
    let moodRise: Date
    let nextFullMoonDays: Int
    let distance: Double

    init(
        phaseName: String,
        moonUrl: String,
        illuminationPercent: Double,
        moodSet: Date,
        moodRise: Date,
        nextFullMoonDays: Int,
        distance: Double
    ) {
        self.phaseName = phaseName
        self.moonUrl = moonUrl
        self.illuminationPercent = illuminationPercent
        self.moodSet = moodSet
        self.moodRise = moodRise
        self.nextFullMoonDays = nextFullMoonDays
        self.distance = distance
    }
}
