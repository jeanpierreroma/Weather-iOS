//
//  File.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 15.10.2025.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var string = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if string.hasPrefix("#") { string.removeFirst() }
        var value: UInt64 = 0
        Scanner(string: string).scanHexInt64(&value)

        let r, g, b: Double
        switch string.count {
        case 6:
            r = Double((value & 0xFF0000) >> 16) / 255.0
            g = Double((value & 0x00FF00) >> 8) / 255.0
            b = Double(value & 0x0000FF) / 255.0
        default:
            r = 0; g = 0; b = 0
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
