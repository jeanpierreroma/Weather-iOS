//
//  UvAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct UvAboutSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "About the UV Index")
            SectionCard {
                Text("""
    The UV Index (UVI) indicates the strength of ultraviolet radiation from the sun. \
    Higher values mean faster skin and eye damage. As a rule of thumb, start using shade, \
    sunscreen, hats and protective clothing from level 3 (Moderate) and above.
    """)
            }
        }
    }
}

#Preview {
    UvAboutSection()
}
