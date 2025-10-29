//
//  MetricPoint.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//


import SwiftUI
import Charts

struct MetricPoint: Identifiable {
    let date: Date
    let value: Double
    var id: Date { date }
}
