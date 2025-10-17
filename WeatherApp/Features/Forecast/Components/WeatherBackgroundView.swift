//
//  WeatherBackgroundView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 11.07.2025.
//

import SwiftUI

struct WeatherFullBackground: View {
    var body: some View {
        ZStack {
            // Базовий градієнт
            WeatherBackgroundView()
            
            // Анімовані частинки (наприклад, дощ)
            AnimatedParticlesBackground()
            
            // Інші ефекти (наприклад, хмари або анімовані зображення)
            // Image("clouds").resizable().opacity(0.2)
            
            SunView()
        }
    }
}


struct SunView: View {
    var body: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 120, height: 120)
            .foregroundStyle(.yellow)
            .opacity(0.8)
            .offset(x: -100, y: -250)
            .shadow(radius: 30)
    }
}


struct WeatherBackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [Color.blue, Color.cyan, Color.cyan],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

struct AnimatedParticlesBackground: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let now = timeline.date.timeIntervalSinceReferenceDate

                for i in 0..<100 {
                    var x = Double(i) * 15.3
                    var y = now * 50 + Double(i) * 80.1
                    x = x.truncatingRemainder(dividingBy: size.width)
                    y = y.truncatingRemainder(dividingBy: size.height)
                    
                    let circle = Path(ellipseIn: CGRect(x: x, y: y, width: 2, height: 2))
                    context.fill(circle, with: .color(.white.opacity(0.4)))
                }
            }
        }
        .ignoresSafeArea()
    }
}


