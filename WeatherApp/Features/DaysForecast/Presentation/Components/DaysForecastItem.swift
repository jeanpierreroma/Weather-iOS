//
//  DaysForecastItem.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 22.10.2025.
//

import SwiftUI

struct DaysForecastItem: View {
    @Environment(\.locale) private var locale
    
    let props: DaysForecastItemProps
    private let barWidth: CGFloat = 100
    
    @State private var measuredTempLabelWidth: CGFloat = 0
    @State private var measuredDayLabelWidth: CGFloat = 0
    
    var body: some View {
        HStack {
            Text(props.dayOfWeek)
                .font(.body)
                .lineLimit(1)
                .frame(width: measuredDayLabelWidth > 0 ? measuredDayLabelWidth : nil,
                       alignment: .leading)
            
            Spacer()
            
            Image(systemName: props.weatherIcon)
            
            Spacer()
               
            temperatureBar(
                labelWidth: measuredTempLabelWidth > 0 ? measuredTempLabelWidth : nil
            )
            .frame(alignment: .trailing)
        }
        .background(
            TempWidthSamples(
                samples: ["-44°", "88°"],
                font: .body,
                monospacedDigits: true
            )
        )
        .onPreferenceChange(TempMaxWidthKey.self) { measuredTempLabelWidth = $0 }
        .background(DayWidthSamples(locale: locale, font: .body, includeToday: "Today"))
        .onPreferenceChange(DayMaxWidthKey.self) { measuredDayLabelWidth = $0 }
    }
    
    @ViewBuilder
    private func temperatureBar(labelWidth: CGFloat?) -> some View {
        HStack(spacing: 4) {
            Text(props.lowestTemperatureText)
                .font(.body)
                .monospacedDigit()
                .lineLimit(1)
                .frame(width: labelWidth, alignment: .trailing)

            LinearGradientScaleBar(
                totalRange: props.lowestTemperature...props.highestTemperature,
                colorStops: [
                    (-40, .purple), (-20, .blue), (0, .cyan),
                    (10, .green), (20, .yellow), (30, .orange), (55, .red)
                ],
                barStyle: .init(barHeight: 6, cornerRadius: 3),
                value: 0,
                indicatorStyle: .init(
                    color: .white, diameter: 6, shadowRadius: 2, shadowOpacity: 0.45
                )
            )
            .frame(width: barWidth, height: 6)

            Text(props.highestTemperatureText)
                .font(.body)
                .monospacedDigit()
                .lineLimit(1)
                .frame(width: labelWidth, alignment: .trailing)
        }
    }
}

#Preview {
    let props_1 = DaysForecastItemProps(
        dayOfWeek: "Today",
        weatherIcon: "sun.max",
        lowestTemperatureText: "-24°",
        highestTemperatureText: "10°",
        lowestTemperature: -24,
        highestTemperature: 10
    )
    
    let props_2 = DaysForecastItemProps(
        dayOfWeek: "Mon",
        weatherIcon: "sun.max",
        lowestTemperatureText: "-24°",
        highestTemperatureText: "2°",
        lowestTemperature: -24,
        highestTemperature: 2
    )
    
    ZStack {
        WeatherGradients.gradient(forSymbol: "sun", isNight: false)
        
        VStack {
            DaysForecastItem(props: props_1)
            DaysForecastItem(props: props_1)
            DaysForecastItem(props: props_2)
            DaysForecastItem(props: props_2)
            DaysForecastItem(props: props_2)
        }
        .padding()
    }
}

private struct TempMaxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = max(value, nextValue()) }
}
private struct TempWidthSamples: View {
    let samples: [String]
    let font: Font
    let monospacedDigits: Bool
    var body: some View {
        ZStack {
            ForEach(samples, id: \.self) { s in
                let t = Text(s).font(font)
                (monospacedDigits ? t.monospacedDigit() : t)
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(key: TempMaxWidthKey.self, value: geo.size.width)
                        }
                    )
                    .hidden().accessibilityHidden(true)
            }
        }
    }
}

private struct DayMaxWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = max(value, nextValue()) }
}

private struct DayWidthSamples: View {
    let locale: Locale
    let font: Font
    let includeToday: String?

    var body: some View {
        let df = DateFormatter()
        df.locale = locale
        let days = df.shortWeekdaySymbols ?? ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        let samples = (includeToday.map { [$0] } ?? []) + days

        return ZStack {
            ForEach(samples, id: \.self) { s in
                Text(s)
                    .font(font)
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(key: DayMaxWidthKey.self, value: geo.size.width)
                        }
                    )
                    .hidden().accessibilityHidden(true)
            }
        }
    }
}
