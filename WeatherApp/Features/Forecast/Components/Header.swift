//
//  Header.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//


import SwiftUI

struct Header: View {
    let cityName: String
    let temperature: String
    let additionalInformation: String
    let hieghtestTemperature: String
    let lowestTemperature: String
    
    init(cityName: String, temperature: String, additionalInformation: String, hieghtestTemperature: String, lowestTemperature: String) {
        
        self.cityName = cityName
        self.temperature = temperature
        self.additionalInformation = additionalInformation
        self.hieghtestTemperature = hieghtestTemperature
        self.lowestTemperature = lowestTemperature
    }
    
    var body: some View {
        VStack {
            Text(cityName)
                .font(.headline)
            Text("\(temperature)°")
                .font(.largeTitle)
            Text(additionalInformation)
                .font(.subheadline)
                .bold(true)
            HStack {
                Text("H: \(hieghtestTemperature)°")
                Text("L: \(lowestTemperature)°")
            }
            .font(.subheadline)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    Header(
        cityName: "Khmelnytskyi",
        temperature: "25",
        additionalInformation: "Sunny",
        hieghtestTemperature: "30", lowestTemperature: "10"
    )
    .padding()
    .background(.blue)
}
