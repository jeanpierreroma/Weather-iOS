//
//  WeatherThemeKey.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//


import SwiftUI

struct WeatherThemeKey: Hashable {
    let kind: WeatherKind
    let isNight: Bool
}