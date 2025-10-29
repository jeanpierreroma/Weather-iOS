//
//  MetricDetailsView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 27.10.2025.
//

import SwiftUI
import Charts

struct MetricDetailsView: View {
    @State private var date: Date = .now
    @State private var tab: ConditionTab = .conditions
    @Environment(\.horizontalSizeClass) private var hSize
    
    let uviProps: UVIDetailsProps
    let humidityProps: HumidityDetailsProps
    let visibilityProps: VisibilityDetailsProps
    let pressureProps: PressureDetailsProps
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CalendarStrip(selectedDate: $date)
                
                Divider()
                
                HStack {
                    // Header
                    Group {
                        switch tab {
                        case .conditions:
                            MetricHeader(value: 11, unit: "°", description: "Actual temperature")
                        case .uvi:
                            MetricHeader(
                                value: uviProps.currentValue,
                                unit: "Low",
                                description: "WHO UV Index (UVI)"
                            )
                        case .humidity:
                            MetricHeader(
                                value: humidityProps.currentValue,
                                unit: "%",
                                description: "Dew point is 23°"
                            )
                        case .pressure:
                            MetricHeader(
                                value: uviProps.currentValue,
                                unit: "hPa",
                                description: "Rising"
                            )
                        case .visibility:
                            MetricHeader(
                                value: pressureProps.currentValue,
                                unit: "km",
                                description: "Perfectly clear"
                            )
                        }
                    }
                    
                    Spacer()
                    
                    Menu {
                        Picker("Condition", selection: $tab) {
                            ForEach(ConditionTab.allCases) { t in
                                Label(t.title, systemImage: t.icon).tag(t)
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: tab.icon)
                            Image(systemName: "chevron.down")
                        }
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(.thinMaterial, in: Capsule())
                        .overlay(
                            Capsule()
                                .stroke(.white.opacity(0.15), lineWidth: 1)
                        )
                        .contentShape(.capsule)
                    }
                }
                .padding(.horizontal)
                .transition(.identity)
                .animation(nil, value: tab)
                
                Group {
                    switch tab {
                    case .conditions:
                        ConditionsTodaySection(
                            temperaturePoint: DemoData.mockTemperatureDataCelsius(),
                            feelsLikePoint: DemoData.mockFeelsLikeTemperatureDataCelsius(),
                            precipitationProbabilityPoint: DemoData.mockPrecipitationProbabilityData(),
                            weatherSymbolsByHour: DemoData.mockWeatherSymbolsByHour()
                        )
                    case .uvi:
                        UvTodaySection(
                            date: date,
                            currentValue: uviProps.currentValue,
                            points: uviProps.points,
                            guidanceText: uviProps.guidanceText,
                            todayPeak: uviProps.todayPeak,
                            yesterdayPeak: uviProps.yesterdayPeak
                        )
                    case .humidity:
                        HumidityTodaySection(
                            date: date,
                            currentValue: humidityProps.currentValue,
                            points: humidityProps.points,
                            dailySummary: humidityProps.dailySummary,
                            todayPeak: humidityProps.todayPeak,
                            yesterdayPeak: humidityProps.yesterdayPeak
                        )
                    case .visibility:
                        VisibilityTodaySection(
                            date: date,
                            currentValue: visibilityProps.currentValue,
                            points: visibilityProps.points,
                            dailySummary: visibilityProps.dailySummary,
                            todayPeak: visibilityProps.todayPeak,
                            yesterdayPeak: visibilityProps.yesterdayPeak
                        )
                    case .pressure:
                        PressureTodaySection(
                            date: date,
                            currentValue: pressureProps.currentValue,
                            points: pressureProps.points,
                            dailySummary: pressureProps.dailySummary
                        )
                    }
                }
                .padding(.horizontal)
                .transition(.identity)
                .animation(nil, value: tab)
            }
        }
    }
}

#Preview {
    let uviProps: UVIDetailsProps = UVIDetailsPresenter.props()
    let humidityProps: HumidityDetailsProps = HumidityDetailsPresenter.props()
    let visibilityProps: VisibilityDetailsProps = VisibilityDetailsPresenter.props()
    let pressureProps: PressureDetailsProps = PressureDetailsPresenter.props()
    
    MetricDetailsView(
        uviProps: uviProps,
        humidityProps: humidityProps,
        visibilityProps: visibilityProps,
        pressureProps: pressureProps
    )
}
