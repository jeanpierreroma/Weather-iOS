//
//  LocationsListView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import SwiftUI

struct LocationsListView: View {
    @State private var query = ""
    let items: [LocationWeatherCardProps]
    
    private var filtered: [LocationWeatherCardProps] {
        guard !query.isEmpty else { return items }
        return items.filter { $0.displayName.localizedStandardContains(query) }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Search
                SearchField(text: $query, placeholder: "Search for a city or airport")

                // Cards
                ForEach(filtered) { props in
                    LocationWeatherCard(props: props)
                        .onTapGesture {
                            
                        }
                }

                // Footer
                WeatherDataFooter(
                    onLearnWeather: { /* open link */ },
                    onLearnMap:     { /* open link */ }
                )
                .padding(.top, 8)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.large)
        .background(Color.black.ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        LocationsListView(items: [
            .init(displayName: "Khmelnytskyi", isMyLocation: true,  isHome: true,  localTime: .now, condition: "Mostly Cloudy", temperature: 15, high: 15, low: 7),
            .init(displayName: "Львів",          isMyLocation: false, isHome: false, localTime: .now, condition: "Partly Cloudy",  temperature: 18, high: 18, low: 9),
            .init(displayName: "Morocco",        isMyLocation: false, isHome: false, localTime: .now, condition: "Mostly Cloudy",  temperature: 29, high: 31, low: 24),
        ])
        .preferredColorScheme(.dark)
    }
}

struct LocationWeatherCardProps: Identifiable, Hashable {
    let id: UUID = .init()
    let displayName: String
    let isMyLocation: Bool
    let isHome: Bool
    let localTime: Date
    let condition: String
    let temperature: Int
    let high: Int
    let low: Int

    // formatting
    var temperatureText: String { "\(temperature)°" }
    var highText: String { "\(high)°" }
    var lowText: String { "\(low)°" }
}

struct SearchField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

struct WeatherDataFooter: View {
    var onLearnWeather: () -> Void
    var onLearnMap: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text("Learn more about ")
                .foregroundStyle(.secondary)
            + Text("weather data").foregroundStyle(.blue).underline()
            + Text(" and ")
            + Text("map data").foregroundStyle(.blue).underline()

            // tappable areas, if потрібно:
            HStack(spacing: 24) {
                Button("weather data", action: onLearnWeather).buttonStyle(.plain).opacity(0.001)
                Button("map data", action: onLearnMap).buttonStyle(.plain).opacity(0.001)
            }
            .frame(height: 0)
        }
        .font(.footnote)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}
