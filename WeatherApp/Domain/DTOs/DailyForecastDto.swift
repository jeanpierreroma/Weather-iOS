//
//  DailyForecastDto.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//

import Foundation

struct DailyForecastDto: Sendable, Decodable {
    let airQualityDetailsDto: AirQualityDetailsDto
    let feelsLikeDetailsDto: FeelsLikeDetailsDto
    let humidityDetailsDto: HumidityDetailsDto
    let precipitationDetailsDto: PrecipitationDetailsDto
    let pressureDetailsDto: PressureDetailsDto
    let sunriseSunsetDetailsDto: SunriseSunsetDetailsDto
    let uvDetailsDto: UvDetailsDto
    let visibilityDetailsDto: VisibilityDetailsDto
    let windDetailsDto: WindDetailsDto
    let moonDetailsDto: MoonDetailsDto
    
    private enum CodingKeys: String, CodingKey {
        case airQualityDetails
        case feelsLikeDetails
        case humidityDetails
        case precipitationDetails
        case pressureDetails
        case sunDetails
        case uvDetails
        case visibilityDetails
        case windDetails
        case moonDetails
    }

    init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        airQualityDetailsDto     = try c.decode(AirQualityDetailsDto.self,     forKey: .airQualityDetails)
        feelsLikeDetailsDto      = try c.decode(FeelsLikeDetailsDto.self,      forKey: .feelsLikeDetails)
        humidityDetailsDto       = try c.decode(HumidityDetailsDto.self,       forKey: .humidityDetails)
        precipitationDetailsDto  = try c.decode(PrecipitationDetailsDto.self,  forKey: .precipitationDetails)
        pressureDetailsDto       = try c.decode(PressureDetailsDto.self,       forKey: .pressureDetails)
        sunriseSunsetDetailsDto  = try c.decode(SunriseSunsetDetailsDto.self,  forKey: .sunDetails)
        uvDetailsDto             = try c.decode(UvDetailsDto.self,             forKey: .uvDetails)
        visibilityDetailsDto     = try c.decode(VisibilityDetailsDto.self,     forKey: .visibilityDetails)
        windDetailsDto           = try c.decode(WindDetailsDto.self,           forKey: .windDetails)
        moonDetailsDto           = try c.decode(MoonDetailsDto.self,           forKey: .moonDetails)
    }
}

struct AirQualityDetailsDto: Sendable, Decodable {
    let airQualityIndex: Double
    let airQualityDetailsCategoryName: String
    let summary: String
}

struct FeelsLikeDetailsDto: Sendable, Decodable {
    let apparentTemperature: Double
    let actualTemperature: Double
    let summary: String
}

struct HumidityDetailsDto: Sendable, Decodable {
    let humidityPercent: Int
    let summary: String
}

struct PrecipitationDetailsDto: Sendable, Decodable {
    let precipitationDuringLast24Hours: Double
    let summary: String
}

struct PressureDetailsDto: Sendable, Decodable {
    let pressureHpa: Int
    let summary: String
}

struct SunriseSunsetDetailsDto: Sendable, Decodable {
    let sunriseText: String
    let sunsetText: String
}

struct UvDetailsDto: Sendable, Decodable {
    let uvIndexValueMax: Double
    let uvIndexRiskCategoryName: String
    let summary: String
}

struct VisibilityDetailsDto: Sendable, Decodable {
    let visibilityKm: Double
    let summary: String
}
 
struct WindDetailsDto: Sendable, Decodable {
    let windSpeedMps: Double
    let gustSpeedMps: Double
    let directionDegrees: Int
}

struct MoonDetailsDto: Sendable, Decodable {
    let phaseName: String
    let illuminationPercent: Double
    let phaseFraction: Double
    let moonsetText: String?
    let daysUntilFullMoon: Int?
}
