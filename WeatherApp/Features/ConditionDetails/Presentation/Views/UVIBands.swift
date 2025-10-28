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

enum VisibilityBands {
    static let standard: [ChartBand] = [
        .init(0...5,    color: .gray.opacity(0.14), id: "vis.01.veryLow"),
        .init(5...10,   color: .gray.opacity(0.18), id: "vis.02.low"),
        .init(10...20,  color: .gray.opacity(0.22), id: "vis.03.moderate"),
        .init(20...35,  color: .gray.opacity(0.26), id: "vis.04.good"),
        .init(35...50,  color: .gray.opacity(0.30), id: "vis.05.excellent")
    ]
}

enum PressureBands {
    static let standard: [ChartBand] = [
        .init(930...960,   color: .purple.opacity(0.20), id: "press.01.veryLow"),
        .init(960...980,   color: .purple.opacity(0.30), id: "press.02.low"),
        .init(980...1000,  color: .purple.opacity(0.40), id: "press.03.normalLow"),
        .init(1000...1020, color: .purple.opacity(0.50), id: "press.04.normalHigh"),
        .init(1020...1040, color: .purple.opacity(0.60), id: "press.05.high"),
        .init(1040...1100, color: .purple.opacity(0.70), id: "press.06.veryHigh")
    ]
}
