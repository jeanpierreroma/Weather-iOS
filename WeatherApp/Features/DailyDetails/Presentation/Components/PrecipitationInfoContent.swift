//
//  PrecipitationInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct PrecipitationInfoContent: InfoBlockContent {
    var header = "Precipitation"
    var headerIconSystemName = "drop.fill"
    
    let props: PrecipitationProps
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                Text(props.valueText)
                    .metricValueStyle()
                
                Text(props.periodTitle)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            Spacer()
            
            Text(props.summaryText)
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
            content: PrecipitationInfoContent(
                props: .init(
                    valueText: "5",
                    periodTitle: "in last 24h",
                    summaryText: "<1 mm expected in next 24h"
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
