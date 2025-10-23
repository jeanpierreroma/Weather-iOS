//
//  RootView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

struct RootView: View {
    @Environment(\.appContainer) private var container
    @State private var selection = 0
    
    let daily: [DailyForecastPoint] = (0..<7).map { i in
        let date = Calendar.current.date(byAdding: .day, value: i, to: Calendar.current.startOfDay(for: .now))!

        let low  = Double(-3 + i)
        let high = Double(low + Double.random(in: 2...12))

        return DailyForecastPoint(
            date: date,
            lowestCelsius: low,
            highestCelsius: high,
            symbol: ["sun.max", "cloud.sun", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
        
    var body: some View {
        TabView {
            ForEach(0..<2, id: \.self) { _ in
                WeatherOverviewView(
                    daily: daily,
                    vm: container.viewModelFactory.makeWeatherOverviewViewModel()
                )
            }
        }
        .tabViewStyle(.page)
        .ignoresSafeArea()
    }
}

#Preview {
    RootView()
}
