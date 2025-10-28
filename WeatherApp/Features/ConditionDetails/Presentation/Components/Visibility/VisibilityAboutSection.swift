//
//  VisibilityAboutSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct VisibilityAboutSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "About Visibility")
            SectionCard {
                Text("""
    Visibility tells you how far away you can clearly see objects like buildings and hills. It is a measure of the transparency of the air and does not take into account the amount of sunlight or the presence of obstructions. Visibility at or above 10 km is considered clear.
    """)
            }
        }
    }
}

#Preview {
    VisibilityAboutSection()
}
