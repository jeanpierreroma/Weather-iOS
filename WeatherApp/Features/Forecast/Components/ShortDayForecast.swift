//
//  ShortDayForecast.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 11.07.2025.
//


import SwiftUI

struct ShortDayForecast: View {
    let dayOfWeek: String
    let weatherIcon: String
    let lowestTemperature: Int
    let highestTemperature: Int
    let currentTemperature: Int
    
    init(dayOfWeek: String, weatherIcon: String, lowestTemperature: Int, highestTemperature: Int, currentTemperature: Int) {
        self.dayOfWeek = dayOfWeek
        self.weatherIcon = weatherIcon
        self.lowestTemperature = lowestTemperature
        self.highestTemperature = highestTemperature
        self.currentTemperature = currentTemperature
    }
    
    var body: some View {
        HStack {
            Text(self.dayOfWeek)
                .frame(width: 60, alignment: .leading)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: weatherIcon)
                .frame(width: 30)
            
            Spacer()
            
            
            Text("\(lowestTemperature)°")
                .font(.headline)
            TemperatureBarView(
                minTemp: lowestTemperature,
                maxTemp: highestTemperature,
                currentTemp: currentTemperature
            )
            .frame(width: 120, height: 8)
            .padding(.horizontal)
            
            Text("\(highestTemperature)°")
                .font(.headline)
        }
    }
}

struct TemperatureBarView: View {
    let minTemp: Int
    let maxTemp: Int
    let currentTemp: Int

    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let range = maxTemp - minTemp
            let clampedTemp = max(min(currentTemp, maxTemp), minTemp)
            let progress = CGFloat(clampedTemp - minTemp) / CGFloat(max(range, 1))

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                Capsule()
                    .fill(Color.orange)
                    .frame(width: totalWidth * progress)
            }
        }
    }
}


#Preview {
    let view = ShortDayForecast(
        dayOfWeek: "Mon",
        weatherIcon: "sun.max",
        lowestTemperature: 14,
        highestTemperature: 20,
        currentTemperature: 17)
    
    return view
}
