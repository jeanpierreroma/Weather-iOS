//
//  HeaderCardPresenter.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import Foundation

enum HeaderCardPresenter {
    static func props(
        city: String,
        currentTemperature: Double,
        additioanlInformation: String,
        highestTemperature: Double,
        lowestTemperature: Double,
        tempUnit: TemperatureDisplayUnit
    ) -> HeaderCardProps {
        let currentTemperatureFormatted = TemperatureFormatter.format(celsius: currentTemperature, to: tempUnit)
        let highestTemperatureFormatted = TemperatureFormatter.format(celsius: highestTemperature, to: tempUnit)
        let lowestTemperatureFormatted = TemperatureFormatter.format(celsius: lowestTemperature, to: tempUnit)
        
        return HeaderCardProps(
            cityName: city,
            currentTempText: currentTemperatureFormatted,
            additioanlInformation: additioanlInformation,
            highestTemperatureText: highestTemperatureFormatted,
            lowestTemperatureText: lowestTemperatureFormatted
        )
    }
}
