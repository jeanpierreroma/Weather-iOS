//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    private let api: WeatherForecastApi
    
    init(api: WeatherForecastApi) {
        self.api = api
    }
    
    func fetchWetherDetails(latitude: Double, longitude: Double) async -> Result<DailyForecastDto, RepositoryFailure> {
        (await api.fetchWeatherForecast(latitude: latitude, longitude: longitude)).mapNetworkFailure()
    }
}

extension Result where Failure == NetworkFailure {
    func mapNetworkFailure() -> Result<Success, RepositoryFailure> {
        switch self {
            
        case .success(let value):
            return .success(value)
        case .failure(let networkFailure):
            return .failure(networkFailure.toRepositoryFailure())
        }
    }
}

extension Result where Failure == RepositoryFailure {
    func mapRepositoryFailure() -> Result<Success, UseCaseFailure> {
        switch self {
            
        case .success(let value):
            return .success(value)
        case .failure(let repositoryFailure):
            return .failure(repositoryFailure.toUseCaseFailure())
        }
    }
}
