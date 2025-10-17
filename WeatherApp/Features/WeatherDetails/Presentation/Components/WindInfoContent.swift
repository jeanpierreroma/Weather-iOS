//
//  WindInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//

import SwiftUI

struct WindInfoContent: InfoBlockContent {
    let header: String = "Wind"
    let headerIconSystemName: String = "wind"
    
    let speed: Measurement<UnitSpeed>
    let directionDegrees: Double
    var arrowShowsSourceDirection: Bool = true
    
    var body: some View {
        HStack(spacing: 12) {
            CompassView(
                directionDegrees: directionDegrees,
                arrowShowsSourceDirection: arrowShowsSourceDirection,
                size: 56
            )

            VStack(alignment: .leading, spacing: 2) {
                Text(Self.format(speed)).font(.title3.weight(.semibold))
                Text("\(Self.cardinal(from: directionDegrees)) • \(Int(directionDegrees))°")
                    .font(.subheadline).foregroundStyle(.secondary)
            }
        }
    }

    private static func format(_ m: Measurement<UnitSpeed>) -> String {
        let f = MeasurementFormatter()
        f.unitOptions = .providedUnit
        f.numberFormatter.maximumFractionDigits = 0
        return f.string(from: m)
    }
    
    private static func cardinal(from degrees: Double) -> String {
        let dirs = ["N","NNE","NE","ENE","E","ESE","SE","SSE",
                    "S","SSW","SW","WSW","W","WNW","NW","NNW"]
        let i = Int((degrees.truncatingRemainder(dividingBy: 360) / 22.5).rounded()) & 15
        return dirs[i]
    }
}

#Preview {
    WindInfoContent(
        speed: .init(value: 5.17, unit: .kilometersPerHour),
        directionDegrees: 315
    )
}

struct CompassStyle: Sendable {
    var ringColor: Color = .secondary.opacity(0.25)
    var majorTickColor: Color = .secondary.opacity(0.65)
    var minorTickColor: Color = .secondary.opacity(0.35)
    var labelColor: Color = .secondary
    var needleColor: Color = .white
    var ringLineWidth: CGFloat = 1
    var majorTickLength: CGFloat = 10
    var mediumTickLength: CGFloat = 7
    var minorTickLength: CGFloat = 4

    static let `default` = CompassStyle()
}

struct CompassView: View {
    /// Метеорологічний кут: 0° = Пн, 90° = Сх, ... (відлік за годинниковою)
    let directionDegrees: Double

    /// true = стрілка показує ЗВІДКИ дме (метео-стандарт),
    /// false = КУДИ дме (додаємо 180°)
    var arrowShowsSourceDirection: Bool = true

    var size: CGFloat = 56
    var style: CompassStyle = .default

    private var normalizedDegrees: Double {
        var d = directionDegrees.truncatingRemainder(dividingBy: 360)
        if d < 0 { d += 360 }
        return d
    }

    private var arrowRotationDegrees: Double {
        let base = normalizedDegrees
        return arrowShowsSourceDirection ? base : (base + 180).truncatingRemainder(dividingBy: 360)
    }

    var body: some View {
        ZStack {
            // Кільце
            Circle()
                .stroke(style.ringColor, lineWidth: style.ringLineWidth)

            // Тікі (кожні 5°; великі кожні 30°, середні кожні 10°)
            ForEach(Array(stride(from: 0, through: 355, by: 5)), id: \.self) { tick in
                let isMajor = tick % 30 == 0
                let isMedium = !isMajor && tick % 10 == 0
                let tickLength = isMajor ? style.majorTickLength : (isMedium ? style.mediumTickLength : style.minorTickLength)
                let tickColor = isMajor ? style.majorTickColor : style.minorTickColor

                Capsule()
                    .fill(tickColor)
                    .frame(width: 1, height: tickLength)
                    .offset(y: -(size / 2) + tickLength / 2 + 4)
                    .rotationEffect(.degrees(Double(tick)))
            }

            // Підписи N/E/S/W
            Group {
                Text("N").font(.caption2.weight(.semibold)).foregroundStyle(style.labelColor)
                    .offset(y: -(size/2) + 14)
                Text("E").font(.caption2.weight(.semibold)).foregroundStyle(style.labelColor)
                    .offset(x:  (size/2) - 12)
                Text("S").font(.caption2.weight(.semibold)).foregroundStyle(style.labelColor)
                    .offset(y:  (size/2) - 14)
                Text("W").font(.caption2.weight(.semibold)).foregroundStyle(style.labelColor)
                    .offset(x: -(size/2) + 12)
            }

            // Стрілка (голка)
            NeedleShape()
                .fill(style.needleColor)
                .frame(width: size * 0.24, height: size * 0.52)
                .rotationEffect(.degrees(arrowRotationDegrees))
                .shadow(color: .black.opacity(0.35), radius: 2, x: 0, y: 1)
        }
        .frame(width: size, height: size)
        .contentShape(Circle())
        .accessibilityLabel("Wind direction")
        .accessibilityValue("\(Int(normalizedDegrees)) degrees")
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: arrowRotationDegrees)
    }
}

/// Проста «голка»: трикутний носик + невеликий хвіст
struct NeedleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        let centerX = rect.midX
        let centerY = rect.midY

        // Трикутний носик (вказує вгору до 0°)
        path.move(to: CGPoint(x: centerX, y: rect.minY))
        path.addLine(to: CGPoint(x: centerX - w/2, y: centerY))
        path.addLine(to: CGPoint(x: centerX + w/2, y: centerY))
        path.closeSubpath()

        // Хвіст (невеликий прямокутник донизу)
        let tailWidth = w * 0.22
        let tailHeight = h * 0.35
        let tailRect = CGRect(
            x: centerX - tailWidth/2,
            y: centerY,
            width: tailWidth,
            height: tailHeight
        )
        path.addRoundedRect(in: tailRect, cornerSize: CGSize(width: tailWidth/2, height: tailWidth/2))

        return path
    }
}
