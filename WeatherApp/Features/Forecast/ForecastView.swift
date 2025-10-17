//
//  ContentView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

struct ForecastView: View {
    private let viewModel: ForecastViewModel
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            WeatherFullBackground()
            
            ScrollView {
                VStack {
                    //MARK: Header
                    Header(
                        cityName: "Khmelnytskyi",
                        temperature: "18°C",
                        additionalInformation: "Feels like: 13°C",
                        hieghtestTemperature: "20°C",
                        lowestTemperature: "14°C"
                    )
                    
                    //MARK: Daily Forecast
                    DailyForecast(
                        dailyWeatherForecast: "Sunny conditions will continue for the rest of the day. Wind gusts are up to 11 m/s.",
                        hourTemperatureList: [
                            HourTemperature(time: 10, temperature: 10, imageName: "sun.max"),
                            HourTemperature(time: 11, temperature: 11, imageName: "sun.max"),
                            HourTemperature(time: 12, temperature: 12, imageName: "sun.max"),
                            HourTemperature(time: 13, temperature: 13, imageName: "sun.max"),
                            HourTemperature(time: 14, temperature: 14, imageName: "sun.max"),
                            HourTemperature(time: 15, temperature: 15, imageName: "sun.max"),
                            HourTemperature(time: 16, temperature: 16, imageName: "sun.max"),
                            HourTemperature(time: 17, temperature: 17, imageName: "sun.max"),
                        ]
                    )
                    
                    //MARK: 10-day Forecast
                    TenDaysForecast(weekForecastList: self.viewModel.getTenDayForecast())
                    
//                    HStack {
//                        SmallInfoBlock(
//                            header: "Feels like",
//                            headerIcon: "thermometer.medium",
//                            suggestion: "Wind is making it feel cooler.")
//                        
//                        
//                        
//                        SmallInfoBlock(
//                            header: "UV index",
//                            headerIcon: "sun.max.fill",
//                            suggestion: "Use sun protection until 18:00.")
//                    }
//                    .padding(.horizontal, 0)
//                    
//                    
//                    HStack {
//                        SmallInfoBlock(
//                            header: "Sunset",
//                            headerIcon: "sunset.fill",
//                            suggestion: "Sunrise: 05:19.")
//                        
//                        
//                        
//                        SmallInfoBlock(
//                            header: "Precipitation",
//                            headerIcon: "drop.fill",
//                            suggestion: "Next expected is 1mm on Tue.")
//                    }
//                    .padding(.horizontal, 0)
//                    
//                    HStack {
//                        SmallInfoBlock(
//                            header: "Visibility",
//                            headerIcon: "eye.fill",
//                            suggestion: "Perfectly clear view.")
//                        
//                        
//                        
//                        SmallInfoBlock(
//                            header: "Humidity",
//                            headerIcon: "humidity.fill",
//                            suggestion: "The dew point is 10° right now.")
//                    }
//                    .padding(.horizontal, 0)
                }
                .padding()
            }
        }
    }
}

#Preview {
    let viewmodel = ForecastViewModel()
    ForecastView(viewModel: viewmodel)
}



struct DailyForecast: View {
    let dailyWeatherForecast: String
    let hourTemperatureList: [HourTemperature]
    
    init(dailyWeatherForecast: String, hourTemperatureList: [HourTemperature]) {
        self.dailyWeatherForecast = dailyWeatherForecast
        self.hourTemperatureList = hourTemperatureList
    }
    
    var body: some View {
        VStack {
            Text(self.dailyWeatherForecast)
            
            HStack {
                ForEach(hourTemperatureList.indices, id: \.self) { index in
                    let item = hourTemperatureList[index]
                    HourlTemperatureCard(
                        hour: item.time,
                        imageName: item.imageName,
                        temperature: item.temperature
                    )
                }
                
            }
        }
        .padding()
        .foregroundStyle(.white)
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct HourlTemperatureCard: View {
    let hour: Int
    let imageName: String
    let temperature: Int
    
    init(hour: Int, imageName: String, temperature: Int) {
        self.hour = hour
        self.imageName = imageName
        self.temperature = temperature
    }
    
    var body: some View {
        VStack {
            Text("\(self.hour)")
            Image(systemName: self.imageName)
            Text("\(temperature)°")
        }
    }
}

struct TenDaysForecast: View {
    let weekForecastList: [DayForecast]
    
    init(weekForecastList: [DayForecast]) {
        self.weekForecastList = weekForecastList
    }
    
    var body: some View {
        ZStack {
            GlassBlockBackground()
            
            VStack(alignment: .leading) {
                //MARK: Header
                HStack(alignment: .center) {
                    Image(systemName: "calendar")
                    Text("10-day forecast")
                }
                
                VStack {
                    ForEach(weekForecastList) { item in
                        ShortDayForecast(
                            dayOfWeek: item.dayOfWeek,
                            weatherIcon: item.weatherIcon,
                            lowestTemperature: item.lowestTemperature,
                            highestTemperature: item.highestTemperature,
                            currentTemperature: 15
                        )
                    }
                }
            }
            .padding()
            .foregroundStyle(.white)
            .cornerRadius(20)
        }
    }
}

//struct GlassBlockBackground: View {
//    var body: some View {
//        Color.black
//            .opacity(0.05) // легке затемнення
//            .blur(radius: 50) // легке розмиття
//            .background(Color.white.opacity(0.15)) // легке світле просвічування
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//            .overlay(
//                RoundedRectangle(cornerRadius: 12)
//                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
//            )
//    }
//}

struct GlassBlockBackground: View {
    var cornerRadius: CGFloat = 12

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.ultraThinMaterial) // справжній системний blur
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.blue.opacity(0.3)) // синє тонування
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.white.opacity(0.08), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}



