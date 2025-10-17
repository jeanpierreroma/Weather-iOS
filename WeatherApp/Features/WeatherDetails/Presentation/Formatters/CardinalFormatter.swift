//
//  CardinalFormatter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

enum CardinalFormatter {
    static func normalizedDegrees(_ degrees: Double) -> Double {
        var d = degrees.truncatingRemainder(dividingBy: 360)
        if d < 0 { d += 360 }
        return d
    }
    static func abbreviation(for degrees: Double) -> String {
        let dirs = ["N","NNE","NE","ENE","E","ESE","SE","SSE",
                    "S","SSW","SW","WSW","W","WNW","NW","NNW"]
        let n = normalizedDegrees(degrees)
        let i = Int((n / 22.5).rounded()) & 15
        return dirs[i]
    }
}


