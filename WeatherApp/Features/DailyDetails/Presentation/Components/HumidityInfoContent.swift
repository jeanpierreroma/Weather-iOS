//
//  HumidityInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct HumidityInfoContent: InfoBlockContent {
    var header = "Humidity"
    var headerIconSystemName = "humidity.fill"
    
    let props: HumidityProps
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(props.valueText)
                .metricValueStyle()
                        
            Text(props.summaryText)
                .metricCaptionStyle()
        }
//        .frame(minWidth: 177, minHeight: 177)
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
            content: HumidityInfoContent(
                props: .init(
                    valueText: "89%",
                    summaryText: "The dew point is 20° right now."
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
