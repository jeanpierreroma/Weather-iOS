//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.userPreferences) private var prefs
    
    var body: some View {
        Form {
//            Picker("Temperature", selection: .init(
//                get: { prefs.prefs.temperatureUnit },
//                set: { prefs.setTemperatureUnit($0) }
//            )) {
//                ForEach(TemperatureUnit.allCases, id: \.self) { unit in
//                    Text(unit == .celsius ? "Celsius" : "Fahrenheit").tag(unit)
//                }
//            }
//
//            Picker("Wind speed", selection: .init(
//                get: { prefs.prefs.windSpeedUnit },
//                set: { prefs.setWindSpeedUnit($0) }
//            )) {
//                ForEach(WindSpeedUnit.allCases, id: \.self) { unit in
//                    Text(label(for: unit)).tag(unit)
//                }
//            }
        }
    }
    
    private func label(for u: WindSpeedUnit) -> String {
        switch u {
        case .kilometersPerHour: return "km/h"
        case .metersPerSecond:   return "m/s"
        case .milesPerHour:      return "mph"
        }
    }
}

#Preview {
    SettingsView()
}
