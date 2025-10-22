//
//  WeatherForecastApiImpl.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//

import Foundation

final class WeatherForecastApiImpl: WeatherForecastApi {
    private let http: HTTPClienting
    private let url: String = "forecast"
    
    init(http: HTTPClienting) { self.http = http }
    
    func fetchWeatherForecast(latitude: Double, longitude: Double) async -> Result<WeatherDataDto, NetworkFailure> {
        var endpoint = Endpoint<WeatherDataDto>(path: url)
        
        endpoint.query = [
            URLQueryItem(name: "latitude", value: "\(52.52)"),
            URLQueryItem(name: "longitude", value: "\(13.41)"),
            URLQueryItem(name: "daily", value: "\("sunrise,sunset,uv_index_max,precipitation_sum,wind_speed_10m_max,wind_gusts_10m_max,wind_direction_10m_dominant")"),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "forecast_days", value: "1"),
            URLQueryItem(name: "timeformat", value: "unixtime")
        ]
        
        let r = await http.send(endpoint)
        print(r)
        return r
    }
}

struct WeatherDataDto: Decodable {
    let daily: Daily

    struct Daily: Decodable {
        let time: [Date]
        let sunrise: [Date]
        let sunset: [Date]
        let uvIndexMax: [Float]
        let precipitationSum: [Float]
        let windSpeed10mMax: [Float]
        let windGusts10mMax: [Float]
        let windDirection10mDominant: [Float]
        
        private enum CodingKeys: String, CodingKey {
            case time                       = "time"
            case sunrise                    = "sunrise"
            case sunset                     = "sunset"
            case uvIndexMax               = "uv_index_max"
            case precipitationSum         = "precipitation_sum"
            case windSpeed10mMax          = "windSpeed"
            case windGusts10mMax          = "windGusts"
            case windDirection10mDominant = "wind_direction_10m_dominant"
        }

        init(from decoder: Decoder) throws {
            let c = try decoder.container(keyedBy: CodingKeys.self)
            time                    = try c.decode([Date].self, forKey: .time)
            sunrise                 = try c.decodeIfPresent([Date].self, forKey: .sunrise) ?? []
            sunset                  = try c.decodeIfPresent([Date].self, forKey: .sunset) ?? []
            uvIndexMax              = try c.decodeIfPresent([Float].self, forKey: .uvIndexMax) ?? []
            precipitationSum        = try c.decodeIfPresent([Float].self, forKey: .precipitationSum) ?? []
            windSpeed10mMax         = try c.decodeIfPresent([Float].self, forKey: .windSpeed10mMax) ?? []
            windGusts10mMax         = try c.decodeIfPresent([Float].self, forKey: .windGusts10mMax) ?? []
            windDirection10mDominant = try c.decodeIfPresent([Float].self, forKey: .windDirection10mDominant) ?? []
        }
    }
}

