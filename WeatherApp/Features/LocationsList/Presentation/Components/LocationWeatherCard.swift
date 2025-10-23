//
//  LocationWeatherCard.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//


import SwiftUI

struct LocationWeatherCard: View {
    let props: LocationWeatherCardProps

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.blue.opacity(0.25), .indigo.opacity(0.25), .gray.opacity(0.15)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .overlay(
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.18)
                    .frame(height: 120)
                    .clipped()
            )

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(props.displayName)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(.white)

                    if props.isMyLocation || props.isHome {
                        HStack(spacing: 6) {
                            if props.isMyLocation {
                                Text("My Location")
                                Image(systemName: "location.fill")
                            }
                            if props.isHome {
                                Text("•")
                                Image(systemName: "house.fill")
                                Text("Home")
                            }
                        }
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.9))
                    }

                    Text(props.condition)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.95))
                }

                Spacer(minLength: 12)

                VStack(alignment: .trailing, spacing: 6) {
                    Text(props.temperatureText)
                        .font(.system(size: 44, weight: .medium, design: .default))
                        .monospacedDigit()
                        .foregroundStyle(.white)

                    HStack(spacing: 8) {
                        Text("H:\(props.highText)")
                        Text("L:\(props.lowText)")
                    }
                    .font(.subheadline.weight(.semibold))
                    .monospacedDigit()
                    .foregroundStyle(.white.opacity(0.95))
                }
            }
            .padding(16)
        }
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .strokeBorder(.white.opacity(0.08))
        )
        .shadow(color: .black.opacity(0.35), radius: 12, x: 0, y: 8)
    }
}

#Preview {
    LocationWeatherCard(
        props: LocationWeatherCardProps(
            displayName: "Lviv",
            isMyLocation: true,
            isHome: true,
            localTime: Date(),
            condition: "Mostly Cloudy",
            temperature: 15,
            high: 15,
            low: 7
        )
    )
    .padding()
}
