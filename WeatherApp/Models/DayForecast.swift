//
//  DayTemperature.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import Foundation

class DayForecast: Identifiable {
    let id = UUID()
    let dayOfWeek: String
    let weatherIcon: String
    let lowestTemperature: Int
    let highestTemperature: Int
    
    init(dayOfWeek: String, weatherImage: String, lowestTemperature: Int, highestTemperature: Int) {
        self.dayOfWeek = dayOfWeek
        self.weatherIcon = weatherImage
        self.lowestTemperature = lowestTemperature
        self.highestTemperature = highestTemperature
    }
}
