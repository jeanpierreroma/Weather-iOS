//
//  ConditionsTodaySection.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

private enum TemperatureSeries: String, CaseIterable, Identifiable {
    case actual = "Actual"
    case feelsLike = "Feels Like"
    var id: Self { self }
}

struct ConditionsTodaySection: View {
    let date: Date = .now
    
    let temperaturePoint: [MetricPoint]
    let feelsLikePoint: [MetricPoint]
    let precipitationProbabilityPoint: [MetricPoint]
    
    let precipitationLast24Hours: Int = 2
    let precipitationNext24Hours: Int = 0
    let precipitationUnit: String = "mm"
    
    let todayLowestTemperatureText: String = "4°"
    let todayHighestTemperatureText: String = "11°"
    let todayLowestTemperature: Double = 4.0
    let todayHighestTemperature: Double = 11.0
    
    let yesturdayLowestTemperatureText: String = "4°"
    let yesturdayHighestTemperatureText: String = "11°"
    let yesturdayLowestTemperature: Double = 4.0
    let yesturdayHighestTemperature: Double = 11.0
    
    @State private var selectedSeries: TemperatureSeries = .actual
    
    private var currentPoints: [MetricPoint] {
        switch selectedSeries {
        case .actual:    return temperaturePoint
        case .feelsLike: return feelsLikePoint
        }
    }
    
    private var currentDescription: String {
        switch selectedSeries {
        case .actual:
            "The actual temperature."
        case .feelsLike:
            "What the temperature feels like as a result of humidity, sunlight or wind."
        }
    }
    
    private var yDomain: ClosedRange<Double> {
        let (minV, maxV) = currentPoints.minMaxValue ?? (0, 1)
        let pad = max(1.0, (maxV - minV) * 0.12) // 12% або ≥1°
        return (minV - pad)...(maxV + pad)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 8) {
                MetricChart(
                    day: date,
                    points: currentPoints,
                    bands: TemperatureBands.standard,
                    yDomain: yDomain,
                    topAxisMode: .averageByBucket(hours: 2),
                    yGridStep: 3
                )
                .padding(.trailing)
                .padding(.top, 8)
                .padding(.bottom, 4)
                .frame(height: 320)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 0.1))
                )
            
                Picker("Temperature", selection: $selectedSeries) {
                    ForEach(TemperatureSeries.allCases) { s in
                        Text(s.rawValue).tag(s)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                .animation(.snappy(duration: 0.2), value: selectedSeries)
                
                
                Text(currentDescription)
                    .font(.footnote)
            }
            
            Divider()
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading) {
                    Text("Chance of Precipitation")
                        .font(.title3.weight(.semibold))
                    
                    Text("Thursday's chanse: 25%")
                        .font(.footnote)
                }
                
                MetricChart(day: date, points: precipitationProbabilityPoint, bands: PrecipitationProbabilityBands.standard, yDomain: 0...100, topAxisMode: .averageByBucket(hours: 0), yGridStep: 20)
                    .padding(.trailing)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .frame(height: 320)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(style: StrokeStyle(lineWidth: 0.1))
                    )
                
                Text("The daily change of precipitation tends to be higher than the chance of each hour.")
                    .font(.footnote)
            }
                        
            ConditionsPrecipitationTotalsSection(
                precipitationLast24Hours: precipitationLast24Hours,
                precipitationNext24Hours: precipitationNext24Hours,
                precipitationUnit: precipitationUnit
            )
            
            ConditionsForecastSection(forecast: "8° now and partly cloudy. Wind is making it feel colder, about 3°. Cloudy conditions expected around 21:00. Today's temperature range is from 4° to 11° and feels like 1° to 5°.")
            
            ConditionsDailyComparisonSection(
                todayLowestTemperatureText: todayLowestTemperatureText,
                todayHighestTemperatureText: todayHighestTemperatureText,
                todayLowestTemperature: todayLowestTemperature,
                todayHighestTemperature: todayHighestTemperature,
                yesturdayLowestTemperatureText: yesturdayLowestTemperatureText,
                yesturdayHighestTemperatureText: yesturdayHighestTemperatureText,
                yesturdayLowestTemperature: yesturdayLowestTemperature,
                yesturdayHighestTemperature: yesturdayHighestTemperature,
                comparisonSentence: "The high temperature today is similar to yesturday."
            )
                       
            MetricAboutSection(
                title: "About Feels Like Temperature",
                text: """
    Feels Like conveys how warm or cold it feels and can be different from the actual temperature. The Feels Like temperature is affected by humidity, sunlight and wind.
    """
            )
        }
        
    }
    
    var minValue: Double {
        Double(temperaturePoint.min(by: { $0.value < $1.value })?.value ?? -40)
    }
    
    var maxValue: Double {
        Double(temperaturePoint.max(by: { $0.value < $1.value })?.value ?? 55)
    }
}

#Preview {
    ScrollView {
        ConditionsTodaySection(
            temperaturePoint: DemoData.mockTemperatureDataCelsius(),
            feelsLikePoint: DemoData.mockFeelsLikeTemperatureDataCelsius(),
            precipitationProbabilityPoint: DemoData.mockPrecipitationProbabilityData()
        )
        .padding(.horizontal)
    }
}

private extension Collection where Element == MetricPoint {
    var minMaxValue: (Double, Double)? {
        guard let first = first else { return nil }
        var mn = first.value, mx = first.value
        for p in dropFirst() {
            if p.value < mn { mn = p.value }
            if p.value > mx { mx = p.value }
        }
        return (mn, mx)
    }
}
