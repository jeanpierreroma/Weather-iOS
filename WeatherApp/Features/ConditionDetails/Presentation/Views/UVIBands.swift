//
//  UVIBands.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

enum UVIBands {
    static let standard: [ChartBand] = [
        .init(0...2,  color: .green,  id: "low"),
        .init(2...5,  color: .yellow, id: "moderate"),
        .init(5...7,  color: .orange, id: "high"),
        .init(7...10, color: .red,    id: "veryHigh"),
        .init(10...11, color: .purple, id: "extreme")
    ]
}
