//
//  SunsetInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 15.10.2025.
//

import SwiftUI

struct SunsetInfoContent: InfoBlockContent {
    var header = "Sunset"
    var headerIconSystemName = "sunset.fill"

    let props: SunProps

    var chartStyle: SunArcChartStyle = .weather(
        gradient: LinearGradient(
            colors: [Color(hex: "#083072"), Color(hex: "#AEC9FF")],
            startPoint: .bottom, endPoint: .top
        )
    )
    var markerStyle: SunMarkerStyle = .white

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Великий час заходу — як заголовок
            Text(props.sunsetText)
                .metricValueStyle()

            SunArcChart(
                dayFraction: props.dayFraction,
                style: chartStyle,
                markerStyle: markerStyle
            )

            Text("Sunrise: \(props.sunriseText)")
                .metricCaptionStyle()
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.indigo, .purple, .pink],
            startPoint: .topLeading, endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        
        HStack {
            InfoBlock(
                content: SunsetInfoContent(
                    props: SunProps(
                        sunriseText: "06:00",
                        sunsetText: "18:00",
                        dayFraction: 0.2
                    )
                )
            )
        }
        .padding()
    }
}
