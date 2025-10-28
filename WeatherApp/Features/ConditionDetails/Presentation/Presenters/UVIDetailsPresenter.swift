//
//  UVIDetailsPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum UVIDetailsPresenter {
    static func props() -> UVIDetailsProps {
        .init(
            points: DemoData.mockUVIData(),
            currentValue: 6,
            guidanceText: "Sun protection recommended. Levels of Moderate or higher are reached from 09:00 to 17:00",
            todayPeak: 1,
            yesterdayPeak: 3
        )
    }
}
