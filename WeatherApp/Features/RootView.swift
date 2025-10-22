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
    
    let hourly = (0..<12).map { i in
        HourForecastPoint(
            date: Calendar.current.date(byAdding: .hour, value: i, to: .now)!,
            celsius: 12 + i/2,
            symbol: ["cloud.sun", "cloud.rain", "sun.max"].randomElement()!
        )
    }
    
    let daily: [DailyForecastPoint] = (0..<7).map { i in
        let date = Calendar.current.date(byAdding: .day, value: i, to: Calendar.current.startOfDay(for: .now))!

        let low  = -3 + i
        let high = low + Int.random(in: 2...12)

        return DailyForecastPoint(
            date: date,
            lowestCelsius: low,
            highestCelsius: high,
            symbol: ["sun.max", "cloud.sun", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
        
    var body: some View {
        ZStack {
            ForEach(0..<2, id: \.self) { _ in
                WeatherOverviewView(
                    hourly: hourly,
                    daily: daily,
                    detailsVM: container.viewModelFactory.makeWeatherDetailsVM(),
                    vm: WeatherOverviewViewModel(hourly: hourly)
                )
            }
            
//            BottomPagerBar(
//                pages: 2,
//                current: selection,
//                onList: {  },
//                onAdd:  {  }
//            )
        }
    }
}

private struct BottomPagerBar: View {
    let pages: Int
    let current: Int
    var onList: () -> Void = {}
    var onAdd: () -> Void  = {}

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onList) { Image(systemName: "list.bullet") }
            Spacer()
            PageDots(count: pages, current: current)
            Spacer()
            Button(action: onAdd) { Image(systemName: "plus") }
        }
        .font(.headline)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.regularMaterial) // як у Weather
    }
}

private struct PageDots: View {
    let count: Int
    let current: Int
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<count, id: \.self) { i in
                Capsule()
                    .frame(width: i == current ? 14 : 6, height: 6)
                    .opacity(i == current ? 1 : 0.35)
                    .animation(.spring(response: 0.35, dampingFraction: 0.8), value: current)
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 4)
        .background(.ultraThinMaterial, in: Capsule())
    }
}
