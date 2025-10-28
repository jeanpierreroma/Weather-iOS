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

enum HumidityBands {
    static let standard: [ChartBand] = [
        .init(0...30,    color: .yellow, id: "rh.01.dry"),
        .init(30...60,   color: .green,  id: "rh.02.comfort"),
        .init(60...80,   color: .orange, id: "rh.03.humid"),
        .init(80...100,  color: .red,    id: "rh.04.oppressive")
    ]
}
