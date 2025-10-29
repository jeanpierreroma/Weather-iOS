//
//  ConditionsDailyComparisonSection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct ConditionsDailyComparisonSection: View {
    let todayLowestTemperatureText: String
    let todayHighestTemperatureText: String
    let todayLowestTemperature: Double
    let todayHighestTemperature: Double
    
    let yesturdayLowestTemperatureText: String
    let yesturdayHighestTemperatureText: String
    let yesturdayLowestTemperature: Double
    let yesturdayHighestTemperature: Double
    
    let comparisonSentence: String
    
    @State private var measuredTempLabelWidth: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitle(text: "Daily Comparison")
            SectionCard(comparisonSentence) {
                HStack {
                    Text("Today")
                    
                    Spacer()
                    
                    TemperatureBar(
                        lowestTemperatureText: todayLowestTemperatureText,
                        highestTemperatureText: todayHighestTemperatureText,
                        lowestTemperature: todayLowestTemperature,
                        highestTemperature: todayHighestTemperature,
                        labelWidth: measuredTempLabelWidth > 0 ? measuredTempLabelWidth : nil
                    )
                }

                
                HStack {
                    Text("Yesturday")
                    
                    Spacer()
                    
                    TemperatureBar(
                        lowestTemperatureText: yesturdayLowestTemperatureText,
                        highestTemperatureText: yesturdayHighestTemperatureText,
                        lowestTemperature: yesturdayLowestTemperature,
                        highestTemperature: yesturdayHighestTemperature,
                        labelWidth: measuredTempLabelWidth > 0 ? measuredTempLabelWidth : nil
                    )
                }
            }
        }
        .onPreferenceChange(TempMaxWidthKey.self) { measuredTempLabelWidth = $0 }
    }
}

#Preview {
    ConditionsDailyComparisonSection(
        todayLowestTemperatureText: "4°",
        todayHighestTemperatureText: "11°",
        todayLowestTemperature: 4.0,
        todayHighestTemperature: 11.0,
        yesturdayLowestTemperatureText: "4°",
        yesturdayHighestTemperatureText: "11°",
        yesturdayLowestTemperature: 4.0,
        yesturdayHighestTemperature: 11.0,
        comparisonSentence: "The high temperature today is similar to yesturday."
    )
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
