//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//

import SwiftUI

struct WeatherDetailsView: View {
    @Environment(\.temperatureUnit) private var temperatureUnit
    @Environment(\.windSpeedUnit) private var windSpeedUnit
    @Environment(\.calendar) private var calendar
    @Environment(\.locale)   private var locale

    @State private var vm = WeatherDetailsViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.indigo, .purple, .pink],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: true) {
                LazyVStack(spacing: 16) {
                    if let details = vm.details {
                        let airQualityProps = AirQualityPresenter.props(from: details.aqi)
                        InfoBlock(content: AirQualityInfoContent(props: airQualityProps))

                        let feelsProp = FeelsLikePresenter.props(from: details.feelsLike, unit: temperatureUnit)
                        let uvProps = UVPresenter.props(from: details.uvDetails)
                        
                        HStack(spacing: 16) {
                            InfoBlock(content: FeelsLikeInfoContent(props: feelsProp))
                                .frame(maxWidth: .infinity)
                            InfoBlock(content: UVIndexInfoContent(props: uvProps))
                                .frame(maxWidth: .infinity)
                        }
                        
                        let windProps = WindPresenter.props(from: details.windDetails, unit: windSpeedUnit)
                        
                        InfoBlock(content: WindInfoContent(props: windProps))

                        let sunProps = SunPresenter.props(from: details.sunDetails, now: Date(), calendar: calendar, locale: locale)
                        let precipProps = PrecipitationPresenter.props(from: details.precipitationDetails)
                        HStack(spacing: 16) {
                            InfoBlock(content: SunsetInfoContent(props: sunProps))
                                .frame(maxWidth: .infinity)

                            InfoBlock(content: PrecipitationInfoContent(props: precipProps))
                                .frame(maxWidth: .infinity)
                        }

                        let visProps = VisibilityPresenter.props(from: details.visibilityDetails)
                        let humidityProps = HumidityPresenter.props(from: details.humidityDetails)
                        HStack(spacing: 16) {
                            InfoBlock(content: VisibilityInfoContent(props: visProps))
                                .frame(maxWidth: .infinity)
                            InfoBlock(content: HumidityInfoContent(props: humidityProps))
                                .frame(maxWidth: .infinity)
                        }
                    } else {
                        ProgressView()
                    }
                }
                .padding()
            }
        }
        .task {
            await vm.loadData()
        }
    }
}

#Preview {
    WeatherDetailsView()
}
