//
//  HumidityDailySummarySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct HumidityDailySummarySection: View {
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
    HumidityDailySummarySection(dailySummary: "Today, the average humidity is 80%. The dew point is 23 all day.")
}
