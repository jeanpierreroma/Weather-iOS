//
//  WaxingCrescentInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 24.10.2025.
//

import SwiftUI

struct WaxingCrescentInfoContent: InfoBlockContent {
    var header: String { props.title }
    var headerIconSystemName: String { props.symbolName }

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
            
            MoonPicture(url: props.currentMoonPicture, size: 110)
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

private struct MoonPicture: View {
    let url: URL
    var size: CGFloat = 110

    var body: some View {
        AsyncImage(url: url, transaction: .init(animation: .snappy(duration: 0.35))) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Circle().fill(.white.opacity(0.08))
                    ProgressView()
                }
                .frame(width: size, height: size)

            case .success(let image):
                Image("Moon")
                  .resizable()
                  .scaledToFill()
                  .frame(width: size, height: size)
                  .clipShape(Circle())

            case .failure:
                Image(systemName: "moon")
                    .imageScale(.large)
                    .frame(width: size, height: size)
                    .background(Circle().fill(.white.opacity(0.08)))
                    .overlay(Circle().stroke(.white.opacity(0.15), lineWidth: 1))
                
            @unknown default:
                Image(systemName: "moon")
                    .imageScale(.large)
                    .frame(width: size, height: size)
                    .background(Circle().fill(.white.opacity(0.08)))
                    .overlay(Circle().stroke(.white.opacity(0.15), lineWidth: 1))
            }
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
                    title: "Waxing Crescent",
                    symbolName: "moonphase.waxing.crescent",
                    illuminationText: "8%",
                    moonsetText: "18:17",
                    nextFullMoonText: "12 days",
                    currentMoonPicture: URL(string: "https://svs.gsfc.nasa.gov/vis/a000000/a005400/a005415/frames/730x730_1x1_30p/moon.7153.jpg")!
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
