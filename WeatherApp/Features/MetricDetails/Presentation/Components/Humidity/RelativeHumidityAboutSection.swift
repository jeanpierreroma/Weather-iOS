//
//  RelativeHumidityAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct RelativeHumidityAboutSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "About Relative Humidity")
            SectionCard {
                Text("""
    Relative humidity, commonly know just as humidity, is the amount of moisture in the air compared with what the air can hold. The air can hold more moisture at higher temperatures. A relative humidity near 100% mean there may be dew or fog.
    """)
            }
        }
    }
}

#Preview {
    RelativeHumidityAboutSection()
}
