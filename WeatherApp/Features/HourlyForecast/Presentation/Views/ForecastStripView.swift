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
    
    @Environment(\.userPreferences) private var prefs
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    
    let hourly: [HourForecastPoint]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 22) {
                ForEach(hourly) { p in
                    let props = HourForecastItemPresenter.props(
                        date: p.date,
                        celsius: p.temperature,
                        symbol: p.symbol,
                        tempUnit: prefs.prefs.temperatureUnit,
                        calendar: calendar,
                        locale: locale
                    )
                    
                    HourForecastItem(props: props)
//                        .background(.red)
                }
            }
        }
    }
}



#Preview {
    ZStack {
//        LinearGradient(
//            colors: [.blue.opacity(0.25), .indigo.opacity(0.25), .gray.opacity(0.15)],
//            startPoint: .topLeading, endPoint: .bottomTrailing
//        )
        
        InfoBlock(
            content: ForecastStripView(
                hourly: (0..<12).map { i in
                    .init(
                        date: Calendar.current.date(byAdding: .hour, value: i, to: .now)!,
                        temperature: Double(12 + i/2),
                        symbol: ["cloud.sun", "cloud.rain", "sun.max"].randomElement()!
                    )
                }
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
    

}
