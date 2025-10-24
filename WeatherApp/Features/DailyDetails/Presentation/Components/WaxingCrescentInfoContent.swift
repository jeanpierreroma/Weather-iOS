//
//  WaxingCrescentInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import SwiftUI

struct WaxingCrescentInfoContent: InfoBlockContent {
    var header = "Waxing crescent"
    
    var headerIconSystemName = "moonphase.waning.gibbous"
    
    let props: WaxingCrescentProps
    
    var body: some View {
        HStack(spacing: 12) {
            VStack {
                InfoTitleValueRow(title: "Illumination", value: props.illuminationText)
                Divider()
                InfoTitleValueRow(title: "Moonset", value: props.moonsetText)
                Divider()
                InfoTitleValueRow(title: "Next Full Moon", value: props.nextFullMoonText)
            }
            
            Circle()
                .frame(width: 110, height: 110)
        }
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

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(
            content: WaxingCrescentInfoContent(
                props: .init(
                    illuminationText: "8%",
                    moonsetText: "18:17",
                    nextFullMoonText: "12 days"
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
