//
//  VisibilityPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import SwiftUI

enum VisibilityPresenter {
    static func props(from details: VisibilityDetails) -> VisibilityProps {
        let km = Int(details.visibilityKm.rounded())
        return VisibilityProps(
            valueText: "\(km) km",
            summaryText: details.summary
        )
    }
}
