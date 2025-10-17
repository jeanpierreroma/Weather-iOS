//
//  HourlTemperature.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

struct HourTemperature {
    let time: Int
    let temperature: Int
    let imageName: String
    
    init(time: Int, temperature: Int, imageName: String) {
        self.time = time
        self.temperature = temperature
        self.imageName = imageName
    }
}
