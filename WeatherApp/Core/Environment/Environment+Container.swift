//
//  Environment+Container.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

private struct TemperatureUnitKey: EnvironmentKey {
    static let defaultValue: TemperatureDisplayUnit = .celsius
}

private struct PressureUnitKey: EnvironmentKey {
    static let defaultValue: PressureDisplayUnit = .hPa
}

private struct WindSpeedUnit: EnvironmentKey {
    static let defaultValue: UnitSpeed = .metersPerSecond
}

extension EnvironmentValues {
    var temperatureUnit: TemperatureDisplayUnit {
        get { self[TemperatureUnitKey.self] }
        set { self[TemperatureUnitKey.self] = newValue }
    }
    
    var pressureUnit: PressureDisplayUnit {
        get { self[PressureUnitKey.self] }
        set { self[PressureUnitKey.self] = newValue }
    }
    
    var windSpeedUnit: UnitSpeed {
        get { self[WindSpeedUnit.self] }
        set { self[WindSpeedUnit.self] = newValue }
    }
}
