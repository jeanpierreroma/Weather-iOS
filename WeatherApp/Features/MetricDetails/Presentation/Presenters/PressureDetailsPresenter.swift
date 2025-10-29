//
//  PressureDetailsPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum PressureDetailsPresenter {
    static func props() -> PressureDetailsProps {
        .init(
            points: DemoData.mockPressureDataHpa(),
            currentValue: 1011,
            dailySummary: "Pressure is currently 1 011 hPa and steady. Today, the average pressure will be 1 008 hPa, and the lowest will be 1 000 hPa."
        )
    }
}
