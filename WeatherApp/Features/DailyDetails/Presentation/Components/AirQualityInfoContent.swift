//
//  AirQualityInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 14.10.2025.
//

import SwiftUI

struct AirQualityInfoContent: InfoBlockContent {
    let header: String = "Air Quality"
    let headerIconSystemName: String = "aqi.low"

    let props: AirQualityProps

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
                totalRange: 0.0...500.0,
                colorStops: props.colorStops,
                barStyle: .init(barHeight: 6, cornerRadius: 3),
                value: props.valueNumber,
                indicatorStyle: .init(color: .white, diameter: 12, shadowRadius: 2, shadowOpacity: 0.5)
            )

            Spacer()

            Text(props.summary)
                .metricCaptionStyle()
        }
    }
}

#Preview {
    var defaultStops: [(Double, Color)] {
        [
            (0,   Color(hex: "#2E7D32")),
            (50,  Color(hex: "#66BB6A")),
            (100, Color(hex: "#FFEB3B")),
            (200, Color(hex: "#FFA726")),
            (300, Color(hex: "#EF5350")),
            (400, Color(hex: "#6D1B1B")),
            (500, Color(hex: "#6D1B1B"))
        ].map { (Double($0.0), $0.1) }
    }
    
    ZStack {
        LinearGradient(
            colors: [.indigo, .purple, .pink],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        InfoBlock(
            content: AirQualityInfoContent(
                props: .init(
                    valueText: "50",
                    valueNumber: 50,
                    categoryTitle: "Good",
                    summary: "Descreption",
                    colorStops: defaultStops
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
