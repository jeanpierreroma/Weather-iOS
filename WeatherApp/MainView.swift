//
//  ContentView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            //MARK: Header
            Header(
                cityName: "Khmelnytskyi",
                temperature: "18°C",
                additionalInformation: "Feels like: 13°C",
                hieghtestTemperature: "20°C",
                lowestTemperature: "14°C"
            )
            
            
            
        }
        .padding()
    }
}

#Preview {
    MainView()
}

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
            Text(temperature)
            Text(additionalInformation)
            HStack {
                Text("H: \(hieghtestTemperature)")
                Text("L: \(lowestTemperature)")
            }
        }
    }
}
