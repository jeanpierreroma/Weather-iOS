//
//  TopAxisMode.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//


import SwiftUI

enum TopAxisMode {
    case perHour
    case averageByBucket(hours: Int)
    case custom(ticks: [Date], label: (Date) -> TopAxisLabel?)
}

