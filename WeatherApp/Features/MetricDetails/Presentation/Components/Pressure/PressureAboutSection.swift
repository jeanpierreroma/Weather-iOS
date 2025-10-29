//
//  PressureAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct PressureAboutSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "About Pressure")
            SectionCard {
                Text("""
    Significant, rapid changes in pressure are used to predict changes in the weather. For example, a drop in pressure can mean that rain or snow is on the way, and rising pressure can mean that weather will improve. Pressure is also called barometric pressure or atmospheric pressure.
    """)
            }
        }
    }
}

#Preview {
    PressureAboutSection()
}
