//
//  VisibilityDetailsPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum VisibilityDetailsPresenter {
    static func props() -> VisibilityDetailsProps {
        .init(
            points: DemoData.mockVisibilityData(),
            currentValue: 32,
            dailySummary: "Today, the lowest visibility will be fairly clear at 5 km, and the highest will be perfectly clear at 35 km.",
            todayPeak: 35,
            yesterdayPeak: 30
        )
    }
}
