//
//  WeatherOverviewView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

struct WeatherOverviewView: View {
    @Environment(\.userPreferences) private var prefs
    @Environment(\.calendar) private var calendar
    @Environment(\.locale) private var locale

    let daily: [DailyForecastPoint]

    @State var vm: WeatherOverviewViewModel
    @State private var scrollOffset: CGFloat = 0
    @State private var baseY: CGFloat?
    
    private var collapseDistance: CGFloat {
        // TODO: change here
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
                        WeatherDetailsView(details: details, hourly: hourly, daily: daily)
                            .backgroundExtensionEffect()
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
        .overlayPreferenceValue(ContentBoundsKey.self) { anchor in
            GeometryReader { proxy in
                let rect = anchor.map { proxy[$0] } ?? .zero
                let y = rect.minY

                Color.clear
                    .onAppear {
                        // TODO: change here
                        baseY = 189
                    }
                    .onChange(of: y) { _, newY in
                        let raw = (baseY ?? newY) - newY
                        scrollOffset = max(0, raw)
                    }
            }
        }
        .background(
            vm.getLLinearGradientBackground()
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

private struct ContentBoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue() ?? value
    }
}
