//
//  SpeedFormatter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import Foundation

enum SpeedFormatter {
    static func text(mps: Double, to unit: UnitSpeed, locale: Locale) -> String {
        let nf = NumberFormatter()
        nf.locale = locale
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0

        let mf = MeasurementFormatter()
        mf.locale = locale
        mf.unitOptions = .providedUnit
        mf.numberFormatter = nf

        let v = Measurement(value: mps, unit: UnitSpeed.metersPerSecond).converted(to: unit)
        return mf.string(from: v)
    }

    static func measurement(mps: Double, to unit: UnitSpeed) -> Measurement<UnitSpeed> {
        Measurement(value: mps, unit: .metersPerSecond).converted(to: unit)
    }
}


