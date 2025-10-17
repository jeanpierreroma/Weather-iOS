//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import Foundation

@MainActor
final class ForecastViewModel: ObservableObject {
    
    private func identifyUserLocation() {
        
    }
    
    private func fetchForecast() {
        
    }
    
    func getTenDayForecast() -> [DayForecast] {
        
        return [
            DayForecast(dayOfWeek: "Monday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Tuesday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Wednesday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Thursday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Friday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Saturday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Sanday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Monday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Tuesday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20),
            DayForecast(dayOfWeek: "Wednesday", weatherImage: "sun.max.fill", lowestTemperature: 14, highestTemperature: 20)
        ]
    }
}
