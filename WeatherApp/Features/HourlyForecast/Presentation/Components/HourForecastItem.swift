//
//  HourlyForecastItemView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import SwiftUI

struct HourForecastItem: View {
    let props: HourForecastItemProps
    private let probabilityPlaceholder = "100%"
    
    var body: some View {
//        GlassEffectContainer {
            VStack(alignment: .center, spacing: 4) {
                Text(props.labelText)
                    .font(.callout.weight(.medium))
                    .monospacedDigit()
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
                
                VStack(spacing: 0) {
                    Image(systemName: props.weatherSymbolName)
                        .imageScale(.large)
                        .symbolRenderingMode(.hierarchical)
                    Text(probabilityPlaceholder)
                        .font(.caption)
                }
                .hidden() // резервує висоту
                .overlay {
                    if let probabilityText = props.weatherProbabilityText {
                        VStack(spacing: 0) {
                            Image(systemName: props.weatherSymbolName)
                                .imageScale(.large)
                                .symbolRenderingMode(.hierarchical)
                            Text(probabilityText)
                                .font(.caption)
                                .lineLimit(1)
                                .minimumScaleFactor(0.85)
                        }
                    } else {
                        Image(systemName: props.weatherSymbolName)
                            .imageScale(.large)
                            .symbolRenderingMode(.hierarchical)
                    }
                }

                
                Text(props.temperatureText)
                    .font(.body.weight(.semibold))
                    .monospacedDigit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)
            }
//            .padding(.vertical)
//            .padding(.horizontal, 10)
//            .background(.red)
//            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 24))
//        }
    }
}

#Preview {
    let props_1 = HourForecastItemProps(
        labelText: "12",
        weatherSymbolName: "cloud.rain.fill",
        weatherProbabilityText: "100%",
        temperatureText: "19°"
    )
    
    let props_2 = HourForecastItemProps(
        labelText: "12",
        weatherSymbolName: "cloud.rain.fill",
        weatherProbabilityText: nil,
        temperatureText: "19°"
    )
    
    HStack(spacing: 8) {
        HourForecastItem(props: props_1)
        HourForecastItem(props: props_2)
    }
}
