//
//  WeatherForecastApiImpl.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

final class WeatherForecastApiImpl: WeatherForecastApi {
    private let http: HTTPClienting
    private let url: String = "weather/daily"
    
    init(http: HTTPClienting) { self.http = http }
    
    func fetchWeatherForecast(latitude: Double, longitude: Double) async -> Result<DailyForecastDto, NetworkFailure> {
        var endpoint = Endpoint<DailyForecastDto>(path: url)
        
        endpoint.query = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "forecast_days", value: "1"),
            URLQueryItem(name: "timezone", value: "auto")
        ]
        
        let r = await http.send(endpoint)
        print(r)
        return r
    }
}
