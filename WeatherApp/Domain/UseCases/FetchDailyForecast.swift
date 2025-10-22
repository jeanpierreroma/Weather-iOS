//
//  FetchDailyForecast.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

struct FetchDailyForecast {
    let repository: WeatherRepository

    /// У яких одиницях приходить вітер у DTO (Open-Meteo daily зазвичай km/h)
    private let inputWindUnit: UnitSpeed = .kilometersPerHour

    func callAsFunction() async -> Result<WeatherDetails, UseCaseFailure> {
        let repoResult = await repository.fetchWetherDetails()

        switch repoResult {
        case .failure(let repoError):
            return .failure(repoError.toUseCaseFailure())

        case .success(let dto):
            let d = dto.daily

            guard let i = indexForToday(dates: d.time, calendar: .autoupdatingCurrent) else {
                return .failure(.repositoryFailure("invalidPayload: missing daily.time for today"))
            }

            // Безпечне діставання значень
            let uv             = Double(d.uvIndexMax[safe: i] ?? 0)
            let precipMm       = Double(d.precipitationSum[safe: i] ?? 0)
            let windSpeedRaw   = Double(d.windSpeed10mMax[safe: i] ?? 0)
            let gustRaw        = Double(d.windGusts10mMax[safe: i] ?? 0)
            let windDirDegrees = Double(d.windDirection10mDominant[safe: i] ?? 0)

            // Конвертація швидкостей до м/с
            let windMps = Measurement(value: windSpeedRaw, unit: inputWindUnit)
                .converted(to: .metersPerSecond).value
            let gustMps = Measurement(value: gustRaw, unit: inputWindUnit)
                .converted(to: .metersPerSecond).value

            // Часи з епохи (секунди)
            guard
                let sunrise = d.sunrise[safe: i],
                let sunset  = d.sunset[safe: i]
            else {
                return .failure(.repositoryFailure("invalidPayload: missing sunrise/sunset"))
            }

            // Побудова доменної моделі
            let details = WeatherDetails(
                aqi: .init(
                    index: 0,
                    summary: "AQI is not provided by the repository."
                ),
                feelsLike: .init(
                    temperature: 0,
                    summary: "Feels-like temperature is not provided."
                ),
                uvDetails: .init(
                    index: Int(uv.rounded()),
                    summary: ""
                ),
                windDetails: .init(
                    windSpeedMps: windMps,
                    gustSpeedMps: gustMps,
                    directionDegrees: windDirDegrees
                ),
                sunDetails: .init(
                    sunrise: sunrise,
                    sunset: sunset
                ),
                precipitationDetails: .init(
                    precipLast24hMm: precipMm,
                    summary: ""
                ),
                visibilityDetails: .init(
                    visibilityKm: 0,
                    summary: "Visibility is not provided."
                ),
                humidityDetails: .init(
                    humidityPercent: 0,
                    summary: "Humidity is not provided."
                ),
                pressureDetails: .init(
                    pressureHpa: 0,
                    summary: "Pressure is not provided."
                )
            )

            return .success(details)
        }
    }

    /// Знаходить індекс елемента для сьогоднішньої дати у масиві epoch-секунд (daily.time).
    private func indexForToday(dates: [Date], calendar: Calendar) -> Int? {
        guard !dates.isEmpty else { return nil }
        let today = calendar.startOfDay(for: Date())
        return dates.firstIndex { calendar.isDate($0, inSameDayAs: today) } ?? dates.indices.first
    }
}

// MARK: - Безпечний доступ до масиву
extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
