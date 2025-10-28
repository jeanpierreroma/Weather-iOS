//
//  DewPointAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct DewPointAboutSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "About Dew Point")
            SectionCard {
                Text("""
    The dew point is what the temperature would need to fall to for dew to form. It can be a useful way to tell how humid the air feels - the higher the dew point, the more humid it feels. A dew point that matches the current temperature means the relative humidity is 100%, and there may be dew or fog.
    """)
            }
        }
    }
}

#Preview {
    DewPointAboutSection()
}
