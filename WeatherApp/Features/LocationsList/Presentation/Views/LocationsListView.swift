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
