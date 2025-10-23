//
//  WeatherOverviewView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

private struct HeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = max(value, nextValue()) }
}
private struct HeightReader: View {
    var onChange: (CGFloat) -> Void
    var body: some View {
        GeometryReader { geo in
            Color.clear.preference(key: HeightKey.self, value: geo.size.height)
        }
        .onPreferenceChange(HeightKey.self) { onChange($0) }
    }
}

struct WeatherOverviewView: View {
    @Environment(\.temperatureUnit) private var tempUnit
    @Environment(\.windSpeedUnit) private var windSpeedUnit
    @Environment(\.calendar) private var calendar
    @Environment(\.locale)   private var locale

    let daily: [DailyForecastPoint]

    @State var vm: WeatherOverviewViewModel
    
    @State private var scrollOffset: CGFloat = 0
    @State private var headerMeasured: CGFloat = 0
    @State private var stripMeasured:  CGFloat = 0
    
    @State private var baseY: CGFloat?
    
    private var collapseDistance: CGFloat {
        return 350
    }
        
    private var expandProgress: CGFloat {
        (scrollOffset / collapseDistance).clamped(to: 0...1)
    }
    
    private var expandProgressBinding: Binding<CGFloat> {
        Binding(
            get: { self.expandProgress },
            set: { newValue in
                let p = newValue.clamped(to: 0...1)
                self.scrollOffset = p * self.collapseDistance
            }
        )
    }
    
    private var headerYOffset: CGFloat {
        -min(18, 18 * expandProgress)
    }

    
    var body: some View {
        VStack(spacing: 0) {
            let headerProps = HeaderCardPresenter.props(
                city: "Lviv",
                currentTemperature: 25,
                additioanlInformation: "Sunny",
                highestTemperature: 30,
                lowestTemperature: 20,
                tempUnit: .celsius
            )
            
            HeaderCard(props: headerProps, progress: expandProgressBinding)
                .padding(.top, 16)
                .offset(y: headerYOffset)
                        
            ScrollView(showsIndicators: false) {
                Color.clear
                    .frame(height: 1)
                    .anchorPreference(key: ContentBoundsKey.self, value: .bounds) { $0 }
                                                                
                VStack(spacing: 12) {
                    Capsule()
                        .fill(.white.opacity(0.35))
                        .frame(width: 44, height: 5)
                        .padding(.top, 8)
                    
                    if let details = vm.details, let hourly = vm.hourly {
                        InfoBlock(content: ForecastStripView(hourly: hourly))
                        InfoBlock(content: DaysForecastView(daily: daily))
                        
                        let airQualityProps = AirQualityPresenter.props(from: details.aqi)
                        InfoBlock(content: AirQualityInfoContent(props: airQualityProps))
                        
                        HStack(spacing: 16) {
                            let feelsProp = FeelsLikePresenter.props(from: details.feelsLike, unit: tempUnit)
                            InfoBlock(content: FeelsLikeInfoContent(props: feelsProp))
                                .frame(maxWidth: .infinity)
                            
                            let uvProps = UVPresenter.props(from: details.uvDetails)
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
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .strokeBorder(.white.opacity(0.1), lineWidth: 1)
                )
                .padding(.top, 150)
            }
        }
        .onPreferenceChange(PartHeightKey.self) { dict in
            if let h = dict[.header] { headerMeasured = h }
            if let s = dict[.strip]  { stripMeasured = s }
        }
        .overlayPreferenceValue(ContentBoundsKey.self) { anchor in
            GeometryReader { proxy in
                let rect = anchor.map { proxy[$0] } ?? .zero
                let y = rect.minY

                Color.clear
                    .onAppear {
                        baseY = 189
                    }
                    .onChange(of: y) { _, newY in
                        let raw = (baseY ?? newY) - newY
                        print(newY)
                        scrollOffset = max(0, raw)
                    }
            }
        }
        .background(
            Image("OverviewBackground")
        )
        .task {
            await vm.loadData()
        }
    }
}


#Preview {

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
    
    let vm = WeatherOverviewViewModel(
        fetchDailyForecastUseCase: FetchDailyForecast(
            repository: WeatherRepositoryImpl(
                api: WeatherForecastApiImpl(
                    http: HTTPClient(
                        config: APIConfig(
                            baseURL: AppConfig.dev.apiBaseURL,
                            enableLogs: AppConfig.dev.enableNetworkLogs
                        )
                    )
                )
            )
        )
    )
    
    WeatherOverviewView(
        daily: daily,
        vm: vm,
    )
}

private enum Part: Hashable { case header, strip }

private struct PartHeightKey: PreferenceKey {
    static var defaultValue: [Part: CGFloat] = [:]
    static func reduce(value: inout [Part: CGFloat], nextValue: () -> [Part: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { max($0, $1) })
    }
}

private struct ContentBoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}

private extension View {
    func measureHeight(_ part: Part) -> some View {
        background(
            GeometryReader { geo in
                Color.clear.preference(key: PartHeightKey.self, value: [part: geo.size.height])
            }
        )
    }
}
