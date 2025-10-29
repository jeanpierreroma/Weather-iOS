//
//  PressureDailySummarySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct PressureDailySummarySection: View {
    let dailySummary: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Daily Summary")
            SectionCard {
                Text(dailySummary)
            }
        }
    }
}

#Preview {
    PressureDailySummarySection(dailySummary: "Pressure is currently 1 010 hPa and rising. Today, the average pressure will be 1 006 hPa, and the lowest pressure will be 1 003 hPa.")
}
