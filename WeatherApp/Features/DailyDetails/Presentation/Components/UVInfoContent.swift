//
//  UVIndexInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct UVInfoContent: InfoBlockContent {
    var header = "UV Index"
    var headerIconSystemName = "sun.max"
    
    let props: UVProps
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(alignment: .leading, spacing: 0) {
                Text(props.valueText)
                    .metricValueStyle()

                Text(props.categoryTitle)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            LinearGradientScaleBar(
                totalRange: 0...11,
                colorStops: props.colorStops,
                barStyle: .init(barHeight: 6, cornerRadius: 3),
                value: props.valueNumber,
                indicatorStyle: .init(color: .white, diameter: 12, shadowRadius: 2, shadowOpacity: 0.45)
            )
            .frame(height: 6)

            Text("Low for the rest of the day.")
                .metricCaptionStyle()
        }
    }
}

#Preview {
    let defaultStops: [(Double, Color)] = [
        (0,  Color(hex: "#2E7D32")), // Low
        (3,  Color(hex: "#FFEB3B")), // Moderate
        (6,  Color(hex: "#EF5350")), // High
        (8,  Color(hex: "#EF5350")), // Very High
        (11, Color(hex: "#51087E"))  // Extreme
    ]
    
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(
            content: UVInfoContent(
                props: .init(
                    valueText: "0",
                    valueNumber: 0,
                    categoryTitle: "Low",
                    summary: "Description",
                    colorStops: defaultStops
                )
            ),
            kind: .clear,
            isNight: false
        )
            .padding()
    }
}
