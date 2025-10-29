//
//  SectionTitle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct SectionTitle: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title3.weight(.semibold))
            .padding(.top, 6)
    }
}

#Preview {
    SectionTitle(text: "About the UV Index")
}
