//
//  PrecipitationPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

enum PrecipitationPresenter {
    static func props(from details: PrecipitationDetails) -> PrecipitationProps {
        PrecipitationProps(
            valueText: "\(details.precipLast24hMm) mm",
            periodTitle: "in last 24h",
            summaryText: details.summary
        )
    }
}
