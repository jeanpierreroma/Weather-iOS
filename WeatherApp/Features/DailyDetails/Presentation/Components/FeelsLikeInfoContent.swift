//
//  FeelsLikeInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct FeelsLikeInfoContent: InfoBlockContent {
    var header = "Feels like"
    var headerIconSystemName = "thermometer.medium"
    
    let props: FeelsLikeProps
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(props.temperatureText)
                .metricValueStyle()

            Spacer()
            
            Text(props.summary)
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
        
        InfoBlock(
            content: FeelsLikeInfoContent(
                props: .init(
                    temperatureText: "21",
                    summary: "Similar to the actual temperature."
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
