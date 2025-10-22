//
//  AppContainer.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 09.10.2025.
//

final class AppContainer {
    private(set) var config: AppConfig

    // Core
    let http: HTTPClienting

    // API
    let forecastApi: WeatherForecastApi

    // Repositories
    let weatherRepository: WeatherRepository

    // UseCases
    let featchDailyForecast: FetchDailyForecast

    let viewModelFactory: ViewModelFactory
    
    init(config: AppConfig) {
        self.config = config

        // Core
        self.http = HTTPClient(
            config: APIConfig(
                baseURL: config.apiBaseURL,
                enableLogs: config.enableNetworkLogs
            )
        )

        // API
        self.forecastApi = WeatherForecastApiImpl(http: http)

        // Repositories
        self.weatherRepository = WeatherRepositoryImpl(api: forecastApi)

        // UseCases (прикладний рівень)
        self.featchDailyForecast = FetchDailyForecast(repository: weatherRepository)
        
        self.viewModelFactory = DefaultViewModelFactory(
            fetchDailyForecastUseCase: featchDailyForecast
        )
    }
}
