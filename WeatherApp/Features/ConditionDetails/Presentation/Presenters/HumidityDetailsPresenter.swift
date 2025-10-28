//
//  HumidityDetailsPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation

enum HumidityDetailsPresenter {
    static func props() -> HumidityDetailsProps {
        .init(
            currentValue: 78,
            points: DemoData.mockHumidityData(),
            dailySummary: "Today, the average humidity is 80%. The dew point is 23 all day.",
            todayPeak: 80,
            yesterdayPeak: 77
        )
    }
}
