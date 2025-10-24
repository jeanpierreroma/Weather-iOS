//
//  WindInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//

import SwiftUI

struct WindInfoContent: InfoBlockContent {
    let header: String = "Wind"
    let headerIconSystemName: String = "wind"

    let props: WindProps

    var body: some View {
        HStack(spacing: 12) {
            VStack {
                InfoTitleValueRow(title: "Wind", value: props.windText)
                Divider()
                InfoTitleValueRow(title: "Gust", value: props.gustText)
                Divider()
                InfoTitleValueRow(title: "Direction", value: props.directionText)
            }
            
            CompassView(
                directionDegrees: props.directionDegrees,
                windSpeed: props.windForCompass,
                size: 110
            )
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(
            content: WindInfoContent(
                props: .init(
                    windText: "18",
                    gustText: "6",
                    directionText: "315",
                    directionDegrees: 315,
                    windForCompass: .init(value: 18, unit: .metersPerSecond)
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}

private struct InfoTitleValueRow: View {
    let title: String
    let value: String
    var spacing: CGFloat = 8

    var body: some View {
        HStack(spacing: spacing) {
            Text(title)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.primary.opacity(0.35))
        }
    }
}
