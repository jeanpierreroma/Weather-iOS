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
                
                HumidityTodaySection(
                    date: date,
                    currentValue: humidityProps.currentValue,
                    points: humidityProps.points,
                    dailySummary: humidityProps.dailySummary,
                    todayPeak: humidityProps.todayPeak,
                    yesterdayPeak: humidityProps.yesterdayPeak
                )
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    let uviProps: UVIDetailsProps = UVIDetailsPresenter.props()
    let humidityProps: HumidityDetailsProps = HumidityDetailsPresenter.props()
    
    ConditionDetailsView(
        uviProps: uviProps,
        humidityProps: humidityProps
    )
}
