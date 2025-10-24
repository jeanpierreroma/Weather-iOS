import SwiftUI

enum WeatherSymbolMapper {
    static func kind(for symbol: String) -> WeatherKind {
        let s = symbol.lowercased()
        if s.contains("bolt") { return .thunderstorm }
        if s.contains("heavyrain") { return .heavyRain }
        if s.contains("drizzle") { return .drizzle }
        if s.contains("rain") { return .rain }
        if s.contains("snow") { return .snow }
        if s.contains("sleet") { return .sleet }
        if s.contains("hail")  { return .hail }
        if s.contains("fog") || s.contains("smoke") || s.contains("haze") { return .fog }
        if s.contains("wind") { return .wind }
        if s.contains("cloud.sun") || s.contains("cloud.moon") { return .partlyCloudy }
        if s.contains("cloud") { return .cloudy }
        if s.contains("sun") || s.contains("moon") { return .clear }
        return .cloudy
    }
}