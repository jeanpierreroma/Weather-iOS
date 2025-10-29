//
//  VisibilityDailySummarySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct VisibilityDailySummarySection: View {
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
    VisibilityDailySummarySection(dailySummary: "Today, the lowest visibility will be fairly clear at 5 km, and the highest will be perfectly clear at 35 km.")
}
