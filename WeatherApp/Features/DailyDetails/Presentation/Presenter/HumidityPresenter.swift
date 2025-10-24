//
//  HumidityPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

enum HumidityPresenter {
    static func props(from details: HumidityDetails) -> HumidityProps {
        HumidityProps(
            valueText: "\(details.humidityPercent)%",
            summaryText: details.summary
        )
    }
}
