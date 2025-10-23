//
//  DaysForecastView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 22.10.2025.
//

import SwiftUI

struct DaysForecastView: InfoBlockContent {
    var header = "10-Day Forecast"
    var headerIconSystemName = "calendar"
    
    @Environment(\.temperatureUnit) private var tempUnit
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    
    let daily: [DailyForecastPoint]
    
    var body: some View {
        VStack(spacing: 24) {
            ForEach(daily) { f in
                let props = DaysForecastItemPresenter.props(
                    date: f.date,
                    lowestCelsius: f.lowestCelsius,
                    highestCelsius: f.highestCelsius,
                    symbol: f.symbol,
                    tempUnit: tempUnit,
                    calendar: calendar,
                    locale: locale
                )
                
                DaysForecastItem(props: props)
            }
        }

    }
}

struct DailyForecastPoint: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let lowestCelsius: Double
    let highestCelsius: Double
    let symbol: String
}

#Preview {
    let cal = Calendar.current
    let today = cal.startOfDay(for: .now)
    let daily: [DailyForecastPoint] = (0..<7).map { i in
        let date = cal.date(byAdding: .day, value: i, to: today)!

        let low  = Double(-3 + i)
        let high = Double(low + Double.random(in: 2...12))

        return DailyForecastPoint(
            date: date,
            lowestCelsius: low,
            highestCelsius: high,
            symbol: ["sun.max", "cloud.sun", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
    
    InfoBlock(content: DaysForecastView(daily: daily))
    .padding()
}
