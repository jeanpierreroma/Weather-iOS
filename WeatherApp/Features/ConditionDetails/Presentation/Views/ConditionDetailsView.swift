//
//  ConditionDetailsView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 27.10.2025.
//

import SwiftUI
import Charts

struct ConditionDetailsView: View {
    @State private var date: Date = .now
    
    let uviProps: UVIDetailsProps
    let humidityProps: HumidityDetailsProps
    let visibilityProps: VisibilityDetailsProps
    let pressureProps: PressureDetailsProps
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CalendarStrip(selectedDate: $date)
                
                Divider()
                
//                UvTodaySection(
//                    date: date,
//                    currentValue: uviProps.currentValue,
//                    points: uviProps.points,
//                    guidanceText: uviProps.guidanceText,
//                    todayPeak: uviProps.todayPeak,
//                    yesterdayPeak: uviProps.yesterdayPeak
//                )
//                .padding(.horizontal)
                
//                HumidityTodaySection(
//                    date: date,
//                    currentValue: humidityProps.currentValue,
//                    points: humidityProps.points,
//                    dailySummary: humidityProps.dailySummary,
//                    todayPeak: humidityProps.todayPeak,
//                    yesterdayPeak: humidityProps.yesterdayPeak
//                )
//                .padding(.horizontal)
                
//                VisibilityTodaySection(
//                    date: date,
//                    currentValue: visibilityProps.currentValue,
//                    points: visibilityProps.points,
//                    dailySummary: visibilityProps.dailySummary,
//                    todayPeak: visibilityProps.todayPeak,
//                    yesterdayPeak: visibilityProps.yesterdayPeak
//                )
//                .padding(.horizontal)
                
                PressureTodaySection(
                    date: date,
                    currentValue: pressureProps.currentValue,
                    points: pressureProps.points,
                    dailySummary: pressureProps.dailySummary
                )
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    let uviProps: UVIDetailsProps = UVIDetailsPresenter.props()
    let humidityProps: HumidityDetailsProps = HumidityDetailsPresenter.props()
    let visibilityProps: VisibilityDetailsProps = VisibilityDetailsPresenter.props()
    let pressureProps: PressureDetailsProps = PressureDetailsPresenter.props()
    
    ConditionDetailsView(
        uviProps: uviProps,
        humidityProps: humidityProps,
        visibilityProps: visibilityProps,
        pressureProps: pressureProps
    )
}
