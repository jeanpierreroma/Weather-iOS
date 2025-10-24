//
//  RootView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

struct RootView: View {
    @Environment(\.appContainer) private var container
    @State private var selection = 0
    @State private var animatedIndex: CGFloat = 0
    
    private let pages = Array(0..<2)
    
    let daily: [DailyForecastPoint] = (0..<7).map { i in
        let date = Calendar.current.date(byAdding: .day, value: i, to: Calendar.current.startOfDay(for: .now))!

        let low  = Double(-3 + i)
        let high = Double(low + Double.random(in: 2...12))

        return DailyForecastPoint(
            date: date,
            lowestCelsius: low,
            highestCelsius: high,
            symbol: ["sun.max", "cloud.sun", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
    
    let bg = WeatherGradients.gradient(forSymbol: "sun", isNight: false)
    let tint = WeatherColors.color(for: .clear, isNight: false)
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(pages, id: \.self) { idx in
                WeatherOverviewView(
                    daily: daily,
                    vm: container.viewModelFactory.makeWeatherOverviewViewModel()
                )
                .background(bg)
                .tag(idx)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onAppear { animatedIndex = CGFloat(selection) }
        .onChange(of: selection) { _, newValue in
            withAnimation(.easeInOut(duration: 0.25)) {
                animatedIndex = CGFloat(newValue)
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Button {
                        // TODO: Open the map
                    } label: {
                        Image(systemName: "map")
                            .imageScale(.large)
                    }
                    
                    Spacer()
                    
                    SlidingPageIndicator(
                        position: animatedIndex,
                        totalCount: pages.count,
                        maxVisible: 5
                    )
                    
                    Spacer()

                    Button {
                        // TODO: Open the Location List
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title3)
                            .padding(12)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
            }
        }
    }
}

#Preview {
    RootView()
}

struct SlidingPageIndicator: View {
    var position: CGFloat
    let totalCount: Int
    var maxVisible: Int = 5

    let minDot: CGFloat = 4
    let maxDot: CGFloat = 8
    let spacing: CGFloat = 6

    var body: some View {
        let step = maxDot + spacing
        let visible = min(maxVisible, totalCount)
        let contentWidth = CGFloat(totalCount) * step
        let viewportWidth = CGFloat(visible) * step
        let halfVisible = (CGFloat(visible) - 1) / 2

        // Центруємо позицію під маскою і затискаємо в межах
        let rawOffset = (position - halfVisible) * step
        let clampedOffset = max(0, min(rawOffset, contentWidth - viewportWidth))

        ZStack {
            HStack(spacing: 0) {
                ForEach(0..<totalCount, id: \.self) { i in
                    let dist = abs(position - CGFloat(i))     // фракційна відстань до активної
                    let t = min(dist / 3.0, 1.0)              // 0…1 в межах «аури»
                    let size = maxDot - (maxDot - minDot) * t // плавне зменшення
                    let opacity = 1 - 0.65 * t                // 1…0.35

                    Circle()
                        .frame(width: size, height: size)
                        .opacity(opacity)
                        .frame(width: step, height: step)     // фікс-слот — для плавного зсуву
                }
            }
            .frame(width: contentWidth, alignment: .leading)
            .offset(x: -clampedOffset)                         // зсуваємо стрічку під маскою
        }
        .frame(width: viewportWidth, height: maxDot)
        .clipped()
        .animation(.easeInOut(duration: 0.22), value: position)
        .accessibilityLabel("Page \(Int(round(position)) + 1) of \(totalCount)")
    }
}


