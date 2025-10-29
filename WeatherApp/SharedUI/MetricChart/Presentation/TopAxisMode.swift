//
//  TopAxisMode.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//


import SwiftUI
import Charts

enum TopAxisMode: Equatable {
    case perHour
    case averageByBucket(hours: Int)
}