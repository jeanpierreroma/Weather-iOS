//
//  AirQualityScaleView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//


import SwiftUI

struct LinearGradientScaleBar: View {
    let totalRange: ClosedRange<Double>
    let colorStops: [(value: Double, color: Color)]
    let value: Double

    let barStyle: ScaleBarStyle
    let indicatorStyle: ScaleIndicatorStyle

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let stops = continuousGradientStops()

            ZStack(alignment: .center) {
                // Градієнтна смуга
                RoundedRectangle(cornerRadius: barCornerRadius)
                    .fill(LinearGradient(gradient: Gradient(stops: stops),
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(height: barHeight)

                // Кружечок-індикатор
                let clamped = min(max(airQualityIndexValue, totalRange.lowerBound), totalRange.upperBound)
                let x = xPosition(for: clamped, totalWidth: width)

                Circle()
                    .fill(indicatorColor)
                    .frame(width: indicatorDiameter, height: indicatorDiameter)
                    .position(x: x, y: barHeight / 2)
                    .shadow(color: indicatorColor.opacity(0.5), radius: 2)
            }
        }
    }

    // MARK: - Helpers

    private func xPosition(for value: Int, totalWidth: CGFloat) -> CGFloat {
        let lower = totalRange.lowerBound
        let upper = totalRange.upperBound
        guard upper > lower else { return 0 }
        let fraction = (Double(value - lower) / Double(upper - lower)).clamped01()
        return CGFloat(fraction) * totalWidth
    }

    private func continuousGradientStops() -> [Gradient.Stop] {
        let lower = totalRange.lowerBound
        let upper = totalRange.upperBound
        let denom = Double(upper - lower)

        var s = colorStops.sorted { $0.value < $1.value }
        if let first = s.first, first.value > lower { s.insert((lower, first.color), at: 0) }
        if let last  = s.last,  last.value  < upper { s.append((upper, last.color)) }

        return s.map { pair in
            let loc = denom > 0 ? (Double(pair.value - lower) / denom).clamped01() : 0
            return Gradient.Stop(color: pair.color, location: CGFloat(loc))
        }
    }
}
