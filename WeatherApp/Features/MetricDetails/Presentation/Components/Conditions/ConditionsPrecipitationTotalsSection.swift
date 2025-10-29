//
//  ConditionsPrecipitationTotalsSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct ConditionsPrecipitationTotalsSection: View {
    let precipitationLast24Hours: Int
    let precipitationNext24Hours: Int
    
    let precipitationUnit: String
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Precipitation Totals")
            SectionCard {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Last 24 hours")
                        Text("Precipitation")
                    }
                    
                    Spacer()
                    
                    (
                        Text("\(precipitationLast24Hours)")
                        +
                        Text(" ")
                        +
                        Text(precipitationUnit)
                    )
                }

                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Next 24 hours")
                        Text("Precipitation")
                    }
                    
                    Spacer()
                    
                    (
                        Text("\(precipitationNext24Hours)")
                        +
                        Text(" ")
                        +
                        Text(precipitationUnit)
                    )
                }
            }
        }
    }
}

#Preview {
    ConditionsPrecipitationTotalsSection(
        precipitationLast24Hours: 2,
        precipitationNext24Hours: 0,
        precipitationUnit: "mm"
    )
}
