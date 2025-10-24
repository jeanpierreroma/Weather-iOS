//
//  FetchDailyForecast.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

struct FetchDailyForecast {
    let repository: WeatherRepository

    func callAsFunction(latitude: Double, longitude: Double) async -> Result<WeatherDetails, UseCaseFailure> {
        let repoResult = await repository.fetchWetherDetails(latitude: latitude, longitude: longitude)

        switch repoResult {
        case .failure(let repoError):
            return .failure(repoError.toUseCaseFailure())

        case .success(let dto):
            let details = DailyForecastMapper.map(dto)
            return .success(details)
        }
    }
}


// MARK: - Mapper
enum DailyForecastMapper {
    static func map(
        _ dto: DailyForecastDto,
        now: Date = Date(),
        calendar: Calendar = .current,
        timeZone: TimeZone = .current,
        locale: Locale = .current
    ) -> WeatherDetails {
        // Air Quality
        let aqiIndex = Int(dto.airQualityDetailsDto.airQualityIndex.rounded())
        let air = AirQualityDetails(
            index: aqiIndex,
            standard: dto.airQualityDetailsDto.airQualityDetailsCategoryName,
            summary: dto.airQualityDetailsDto.summary
        )

        // Feels Like
        let feels = FeelsLikeDetails(
            apparentTemperature: dto.feelsLikeDetailsDto.apparentTemperature,
            actualTemperature: dto.feelsLikeDetailsDto.actualTemperature,
            summary: dto.feelsLikeDetailsDto.summary
        )

        // UV
        let uvIndex = Int(dto.uvDetailsDto.uvIndexValueMax.rounded())
        let uv = UVDetails(
            index: uvIndex,
            standard: dto.uvDetailsDto.uvIndexRiskCategoryName,
            summary: dto.uvDetailsDto.summary
        )

        // Wind
        let wind = WindDetails(
            windSpeedMps: dto.windDetailsDto.windSpeedMps,
            gustSpeedMps: dto.windDetailsDto.gustSpeedMps,
            directionDegrees: Double(dto.windDetailsDto.directionDegrees)
        )

        // Sun
        let sunrise = parseSunTime(
            dto.sunriseSunsetDetailsDto.sunriseText,
            now: now, calendar: calendar, timeZone: timeZone, locale: locale
        )
        let sunset = parseSunTime(
            dto.sunriseSunsetDetailsDto.sunsetText,
            now: now, calendar: calendar, timeZone: timeZone, locale: locale
        )
        let sun = SunDetails(sunrise: sunrise, sunset: sunset)

        // Precipitation
        let precip = PrecipitationDetails(
            precipLast24hMm: dto.precipitationDetailsDto.precipitationDuringLast24Hours,
            summary: dto.precipitationDetailsDto.summary
        )

        // Visibility
        let vis = VisibilityDetails(
            visibilityKm: dto.visibilityDetailsDto.visibilityKm,
            summary: dto.visibilityDetailsDto.summary
        )

        // Humidity
        let humidity = HumidityDetails(
            humidityPercent: dto.humidityDetailsDto.humidityPercent,
            summary: dto.humidityDetailsDto.summary
        )

        // Pressure
        let pressure = PressureDetails(
            pressureHpa: dto.pressureDetailsDto.pressureHpa,
            summary: dto.pressureDetailsDto.summary
        )

        return WeatherDetails(
            aqi: air,
            feelsLike: feels,
            uvDetails: uv,
            windDetails: wind,
            sunDetails: sun,
            precipitationDetails: precip,
            visibilityDetails: vis,
            humidityDetails: humidity,
            pressureDetails: pressure
        )
    }

    // MARK: - Helpers

    /// Парсить час світанку/заходу з тексту.
    /// Підтримує ISO-8601, а також локальні формати часу на кшталт "06:47", "6:47 AM".
    /// Якщо це лише «час», — підставляємо поточну дату `now` у вказаній `timeZone`.
    private static func parseSunTime(
        _ text: String,
        now: Date,
        calendar: Calendar,
        timeZone: TimeZone,
        locale: Locale
    ) -> Date {
        // 1) ISO-8601 (з/без дробних секунд)
        if let d = iso8601WithFraction.date(from: text) ?? iso8601.date(from: text) {
            return d
        }

        // 2) Спробуємо поширені часові формати
        for f in timeFormatters(locale: locale, timeZone: timeZone) {
            if let t = f.date(from: text) {
                // переносимо H/M/S на сьогоднішню дату
                let tzCal = calendarSetting(calendar, timeZone: timeZone)
                let day = tzCal.dateComponents(in: timeZone, from: now)
                var comps = DateComponents()
                comps.year = day.year
                comps.month = day.month
                comps.day = day.day

                let time = tzCal.dateComponents([.hour, .minute, .second], from: t)
                comps.hour = time.hour
                comps.minute = time.minute
                comps.second = time.second

                return tzCal.date(from: comps) ?? now
            }
        }

        // 3) Фолбек — повертаємо now (або можна кинути в лог/метрику)
        return now
    }

    private static let iso8601: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f
    }()

    private static let iso8601WithFraction: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return f
    }()

    private static func timeFormatters(locale: Locale, timeZone: TimeZone) -> [DateFormatter] {
        let patterns = [
            "HH:mm:ss", "HH:mm",
            "H:mm:ss",  "H:mm",
            "h:mm:ss a","h:mm a"
        ]
        return patterns.map { p in
            let df = DateFormatter()
            df.locale = locale
            df.timeZone = timeZone
            df.dateFormat = p
            return df
        }
    }

    private static func calendarSetting(_ base: Calendar, timeZone: TimeZone) -> Calendar {
        var cal = base
        cal.timeZone = timeZone
        return cal
    }
}
