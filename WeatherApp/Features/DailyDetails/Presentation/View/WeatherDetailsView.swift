//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import SwiftUI

struct WeatherDetailsView: View {
    @Environment(\.userPreferences) private var prefs
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale
    
    let details: WeatherDetails
    let hourly: [HourForecastPoint]
    let daily: [DailyForecastPoint]
    
    private let vSpacing: CGFloat = 16
    private let hSpacing: CGFloat = 16
    
    
    init(
        details: WeatherDetails,
        hourly: [HourForecastPoint],
        daily: [DailyForecastPoint]
    ) {
        self.details = details
        self.hourly = hourly
        self.daily = daily
    }
    
    var body: some View {
        VStack(spacing: vSpacing) {
            InfoBlock(
                content: ForecastStripView(hourly: hourly),
                kind: .clear,
                isNight: false
            )
            InfoBlock(
                content: DaysForecastView(daily: daily),
                kind: .clear,
                isNight: false
            )
            InfoBlock(
                content: AirQualityInfoContent(props: airQualityProps),
                kind: .clear,
                isNight: false
            )
            
            HStack(spacing: hSpacing) {
                InfoBlock(
                    content: FeelsLikeInfoContent(props: feelsProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
                
                InfoBlock(
                    content: AveragesInfoContent(
                        props: .init(
                            differenceText: "+8°",
                            summary: "above average daily high",
                            todayAverageText: "H:17°",
                            averageText: "H:9°"
                        )
                    ),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
            }
            
            InfoBlock(
                content: WindInfoContent(props: windProps),
                kind: .clear,
                isNight: false
            )
            
            HStack(spacing: hSpacing) {
                InfoBlock(
                    content: UVIndexInfoContent(props: uvProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
                
                InfoBlock(
                    content: SunsetInfoContent(props: sunProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
            }
            
            HStack(spacing: hSpacing) {
                InfoBlock(
                    content: PrecipitationInfoContent(props: precipProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
                
                InfoBlock(
                    content: VisibilityInfoContent(props: visProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
            }
            
            InfoBlock(
                content: WaxingCrescentInfoContent(props: moonProps),
                kind: .clear,
                isNight: false
            )
            
            HStack(spacing: hSpacing) {
                InfoBlock(
                    content: HumidityInfoContent(props: humidityProps),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
                
                InfoBlock(
                    content: PressureInfoContent(currentPressure: 996),
                    kind: .clear,
                    isNight: false
                )
                .frame(maxWidth: .infinity)
            }

        }
    }
    
    private var airQualityProps: AirQualityProps {
        AirQualityPresenter.props(from: details.aqi)
    }
    
    private var feelsProps: FeelsLikeProps {
        FeelsLikePresenter.props(from: details.feelsLike, unit: prefs.prefs.temperatureUnit)
    }
    
    private var uvProps: UVProps {
        UVPresenter.props(from: details.uvDetails)
    }
    
    private var sunProps: SunProps {
        SunPresenter.props(from: details.sunDetails, now: Date(), calendar: calendar, locale: locale)
    }
    
    private var windProps: WindProps {
        WindPresenter.props(from: details.windDetails, unit: prefs.prefs.windSpeedUnit)
    }
    
    private var precipProps: PrecipitationProps {
        PrecipitationPresenter.props(from: details.precipitationDetails)
    }
    
    private var visProps: VisibilityProps {
        VisibilityPresenter.props(from: details.visibilityDetails)
    }
    
    private var moonProps: WaxingCrescentProps {
        MoonPresenter.props(from: details.moonDetails, calendar: calendar, locale: locale)
    }
    
    private var humidityProps: HumidityProps {
        HumidityPresenter.props(from: details.humidityDetails)
    }
}

#Preview {
    let details = WeatherDetails(
        aqi: .init(index: 50, standard: "Good", summary: "Air quality index is \(50), which is similar to yesterday at about this time."),
        feelsLike: .init(apparentTemperature: 21, actualTemperature: 20, summary: "Similar to the actual temperature."),
        uvDetails: .init(index: 0, standard: "Low", summary: ""),
        windDetails: .init(windSpeedMps: 18, gustSpeedMps: 6, directionDegrees: 315),
        sunDetails: .init(
            sunrise: Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: .now)!,
            sunset: Calendar.current.date(bySettingHour: 18, minute: 16, second: 0, of: .now)!
        ),
        precipitationDetails: .init(precipLast24hMm: 5, summary: "<1 mm expected in next 24h"),
        visibilityDetails: .init(visibilityKm: 16, summary: "Perfectly clear view."),
        humidityDetails: .init(humidityPercent: 89, summary: "The dew point is 20° right now."),
        pressureDetails: .init(pressureHpa: 1024, summary: ""),
        moonDetails: .init(
            phaseName: "Waxing Crescent",
            illuminationPercent: 8,
            phaseFraction: 0.22,
            moonset: Calendar.current.date(bySettingHour: 18, minute: 17, second: 0, of: .now)!,
            daysUntilFullMoon: 12
        )
    )
    
    let hourly: [HourForecastPoint] = (0..<12).map { i in
        HourForecastPoint(
            date: Calendar.current.date(byAdding: .hour, value: i, to: .now)!,
            temperature: Double(12 + i/2),
            symbol: ["cloud.sun", "cloud.rain", "sun.max"].randomElement()!
        )
    }
    
    let cal = Calendar.current
    let today = cal.startOfDay(for: .now)
    let daily: [DailyForecastPoint] = (0..<7).map { i in
        let date = cal.date(byAdding: .day, value: i, to: today)!

        let low  = Double(-3 + i)
        let high = Double(low + Double.random(in: 2...12))

        return DailyForecastPoint(
            date: date,
            lowestCelsius: low,
            highestCelsius: high,
            symbol: ["sun.max", "cloud.sun", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
    
    ScrollView {
        WeatherDetailsView(
            details: details,
            hourly: hourly,
            daily: daily
        )
        .padding(.horizontal)
    }
}
