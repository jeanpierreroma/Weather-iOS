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
    
    let props: UVIDetailsProps
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CalendarStrip(selectedDate: $date)
                
                Divider()
                
                UvTodaySection(
                    date: date,
                    currentValue: props.currentValue,
                    points: props.points,
                    guidanceText: props.guidanceText
                )
                .padding(.horizontal)
                
                Divider()
                
                UvDailyComparisonSection(
                    todayPeak: props.todayPeak,
                    yesterdayPeak: props.yesterdayPeak
                )
                
                UvAboutSection()
            }
        }
    }
}

#Preview {
    let props: UVIDetailsProps = UVIDetailsPresenter.props()
    
    ConditionDetailsView(props: props)
}
