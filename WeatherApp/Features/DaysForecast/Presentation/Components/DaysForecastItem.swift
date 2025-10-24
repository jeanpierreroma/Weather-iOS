//
//  DaysForecastItem.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 22.10.2025.
//

import SwiftUI

struct DaysForecastItem: View {
    let props: DaysForecastItemProps
    
    var body: some View {
        HStack {
            Text(props.dayOfWeek)
                .background()
            
            Spacer()
            
            Image(systemName: props.weatherIcon)
                .padding(.trailing, 30)
                .background()
                        
            HStack(spacing: 8) {
                Text(props.lowestTemperatureText)
                    .monospacedDigit()
                
                LinearGradientScaleBar(
                    totalRange: -40...55,
                    colorStops: [
                        (-40, .purple),
                        (-20, .blue),
                        (  0, .cyan),
                        ( 10, .green),
                        ( 20, .yellow),
                        ( 30, .orange),
                        ( 55, .red)
                    ],
                    value: 0,
                    barStyle: .init(barHeight: 6, cornerRadius: 3),
                    indicatorStyle: .init(
                        color: .white,
                        diameter: 6,
                        shadowRadius: 2,
                        shadowOpacity: 0.45
                    )
                )
                .frame(width: 100, height: 6)
                
                
                Text(props.highestTemperatureText)
                    .monospacedDigit()
            }
            .background(.red)
        }
    }
}

#Preview {
    let props = DaysForecastItemProps(
        dayOfWeek: "Today",
        weatherIcon: "sun.max",
        lowestTemperatureText: "-24°",
        highestTemperatureText: "10°"
    )
    
    ZStack {
        WeatherGradients.gradient(forSymbol: "sun", isNight: false)
        
        VStack {
            DaysForecastItem(props: props)
            DaysForecastItem(props: props)
            DaysForecastItem(props: props)
            DaysForecastItem(props: props)
            DaysForecastItem(props: props)
        }
        .padding()
    }
    

}


enum TemperatureScale {
    static let celsiusRange: ClosedRange<Double> = -40...55
    static let celsiusStops: [(Double, Color)] = [
        (-40, .purple),
        (-20, .blue),
        (  0, .cyan),
        ( 10, .green),
        ( 20, .yellow),
        ( 30, .orange),
        ( 55, .red)
    ]

    static func rangeAndStops(for unit: TemperatureUnit) -> (ClosedRange<Double>, [(Double, Color)]) {
        switch unit {
        case .celsius:
            return (celsiusRange, celsiusStops)
        case .fahrenheit:
            func cToF(_ c: Double) -> Double { c * 9/5 + 32 }
            let fr: ClosedRange<Double> = cToF(celsiusRange.lowerBound)...cToF(celsiusRange.upperBound)
            let fs = celsiusStops.map { (cToF($0.0), $0.1) }
            return (fr, fs)
        }
    }
}
