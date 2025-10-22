//
//  ForecastStripView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import SwiftUI

struct ForecastStripView: InfoBlockContent {
    var header = "Hourly Forecast"
    var headerIconSystemName = "clock"
    
    @Environment(\.temperatureUnit) private var tempUnit
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    
    let hourly: [HourForecastPoint]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(hourly) { p in
                    let props = HourForecastItemPresenter.props(
                        date: p.date,
                        celsius: p.celsius,
                        symbol: p.symbol,
                        tempUnit: tempUnit,
                        calendar: calendar,
                        locale: locale
                    )
                    
                    HourForecastItem(props: props)
                }
            }
        }
    }
}

struct HourForecastPoint: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let celsius: Int
    let symbol: String
}

#Preview {
    InfoBlock(
        content: ForecastStripView(
            hourly: (0..<12).map { i in
                .init(date: Calendar.current.date(byAdding: .hour, value: i, to: .now)!,
                      celsius: 12 + i/2,
                      symbol: ["cloud.sun", "cloud.rain", "sun.max"].randomElement()!)
            }
        )
    )
    .padding()
}
