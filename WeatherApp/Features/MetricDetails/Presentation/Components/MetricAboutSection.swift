//
//  MetricAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct MetricAboutSection: View {
    let title: String
    let text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: title)
            SectionCard {
                Text(text)
            }
        }
    }
}

#Preview {
    MetricAboutSection(
        title: "About Relative Humidity",
        text: """
    Relative humidity, commonly know just as humidity, is the amount of moisture in the air compared with what the air can hold. The air can hold more moisture at higher temperatures. A relative humidity near 100% mean there may be dew or fog.
    """
    )
}
