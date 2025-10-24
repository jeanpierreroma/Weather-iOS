//
//  FeelsLikeInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct FeelsLikeInfoContent: InfoBlockContent {
    var header = "Feels like"
    var headerIconSystemName = "thermometer.medium"
    
    let props: FeelsLikeProps
    
    private let barHeight: CGFloat = 6
    private let showThreshold: Double = 3
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(props.apparentTemperatureText)
                .metricValueStyle()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Actual: \(props.actualTemperatureText)")
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                

                Rectangle().fill(.clear)
                    .frame(height: barHeight)
                    .accessibilityHidden(true)
            }
            
            .hidden()
            .overlay(alignment: .topLeading) {
                if showBar {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Actual: \(props.actualTemperatureText)")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .lineLimit(1)

                        LinearGradientScaleBar(
                            totalRange: range,
                            colorStops: [
                                (-40, .purple), (-20, .blue), (0, .cyan),
                                (10, .green), (20, .yellow), (30, .orange), (55, .red)
                            ],
                            barStyle: .init(barHeight: barHeight, cornerRadius: 3),
                            value: nil,
                            indicatorStyle: .init(
                                color: .white, diameter: 6, shadowRadius: 2, shadowOpacity: 0.45
                            )
                        )
                        .frame(height: barHeight)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
            }
            .animation(.easeInOut(duration: 0.25), value: showBar)
                
            Text(props.summary)
                .metricCaptionStyle()
        }
    }
    
    private var showBar: Bool {
        abs(props.apparentTemperatureValue - props.actualTemperatureValue) > showThreshold
    }

    private var range: ClosedRange<Double> {
        let lo = min(props.apparentTemperatureValue, props.actualTemperatureValue)
        let hi = max(props.apparentTemperatureValue, props.actualTemperatureValue)
        return lo...hi
    }
}

#Preview("Feels like with indicator") {
    ZStack {
        WeatherGradients.gradient(for: .clear, isNight: false)
        
        InfoBlock(
            content: FeelsLikeInfoContent(
                props: .init(
                    apparentTemperatureText: "11°",
                    actualTemperatureText: "17°",
                    summary: "Similar to th actual temperature.",
                    apparentTemperatureValue: 11,
                    actualTemperatureValue: 17
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}

#Preview("Feels like without indicator") {
    ZStack {
        WeatherGradients.gradient(for: .clear, isNight: false)
        
        InfoBlock(
            content: FeelsLikeInfoContent(
                props: .init(
                    apparentTemperatureText: "16°",
                    actualTemperatureText: "17°",
                    summary: "Similar to th actual temperature.",
                    apparentTemperatureValue: 16,
                    actualTemperatureValue: 17
                )
            ),
            kind: .clear,
            isNight: false
        )
        .padding()
    }
}
