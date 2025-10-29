//
//  ConditionsForecastSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct ConditionsForecastSection: View {
    let forecast: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Forecast")
            SectionCard {
                Text(forecast)
            }
        }
    }
}

#Preview {
    ConditionsForecastSection(forecast: "8° now and partly cloudy. Wind is making it feel colder, about 3°. Cloudy conditions expected around 21:00. Today's temperature range is from 4° to 11° and feels like 1° to 5°.")
}
