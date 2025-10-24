//
//  CompassView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//


import SwiftUI

struct CompassView: View {
    let directionDegrees: Double
    let windSpeed: Measurement<UnitSpeed>?

    var size: CGFloat = 128
    var style: CompassStyle = .default
    
    private enum Constants {
        // Тікі
        static let tickStepDegrees: Int = 5
        static let tickMaxDegrees: Int = 355
        static let majorTickModulo: Int = 30
        static let mediumTickModulo: Int = 10
        static let tickWidth: CGFloat = 1

        // Демо-параметри стрілки (як у твоєму прикладі виклику)
        static let arrowDirectionDegreesDemo: Double = 100
        static let arrowCenterBadgeDiameter: CGFloat = 128
        static let arrowGapBetweenBadgeAndArrow: CGFloat = 8
        static let arrowShaftWidth: CGFloat = 6
        static let arrowHeadLengthFraction: CGFloat = 0.28
        static let arrowHeadWidthMultiplier: CGFloat = 2.0
        static let arrowFillColor: Color = .gray.opacity(0.85)
        static let arrowStrokeColor: Color = .blue
        static let arrowStrokeLineWidth: CGFloat = 1
        static let arrowContainerSize: CGFloat = 200
        static let arrowContainerPadding: CGFloat = 0
    }

    private var normalizedDegrees: Double {
        var d = directionDegrees.truncatingRemainder(dividingBy: 360)
        if d < 0 { d += 360 }
        return d
    }

    private var formattedSpeed: String {
        guard let windSpeed else { return "—" }
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter.string(from: windSpeed)
    }

    var body: some View {
        ZStack {
            // Тікі (кожні 5°; великі кожні 30°, середні кожні 10°)
            ForEach(
                Array(stride(from: 0, through: Constants.tickMaxDegrees, by: Constants.tickStepDegrees)),
                id: \.self
            ) { tick in
                if shouldSkipTickForLabels(angleDegrees: Double(tick),
                                           clearanceDegrees: style.labelClearanceDegrees) {
                    EmptyView()
                } else {
                    let isMajor = tick % Constants.majorTickModulo == 0
                    let isMedium = !isMajor && tick % Constants.mediumTickModulo == 0
                    let tickLength = isMajor ? style.majorTickLength
                                             : (isMedium ? style.mediumTickLength : style.minorTickLength)
                    let tickColor = isMajor ? style.majorTickColor : style.minorTickColor

                    Capsule()
                        .fill(tickColor)
                        .frame(width: Constants.tickWidth, height: tickLength)
                        .offset(y: -(size / 2) + tickLength / 2 + style.tickInnerPadding)
                        .rotationEffect(.degrees(Double(tick)))
                }
            }

            // Підписи N/E/S/W
            Group {
                Text("N")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(style.labelColor)
                    .offset(y: -(size / 2) + style.labelInset)

                Text("E")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(style.labelColor)
                    .offset(x:  (size / 2) - style.labelInset)

                Text("S")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(style.labelColor)
                    .offset(y:  (size / 2) - style.labelInset)

                Text("W")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(style.labelColor)
                    .offset(x: -(size / 2) + style.labelInset)
            }

            ArrowWithCenterBadge(
                directionDegrees: Constants.arrowDirectionDegreesDemo,
                centerBadgeDiameter: Constants.arrowCenterBadgeDiameter,
                gapBetweenBadgeAndArrow: Constants.arrowGapBetweenBadgeAndArrow,
                shaftWidth: Constants.arrowShaftWidth,
                headLengthFraction: Constants.arrowHeadLengthFraction,
                headWidthMultiplier: Constants.arrowHeadWidthMultiplier,
                arrowFill: Constants.arrowFillColor,
                arrowStroke: Constants.arrowStrokeColor,
                arrowStrokeLineWidth: Constants.arrowStrokeLineWidth
            ) {
                Text(formattedSpeed)
                    .font(style.centerBadgeFont)
                    .foregroundStyle(style.centerBadgeTextColor)
                    .frame(width: size * style.centerBadgeDiameterFraction,
                           height: size * style.centerBadgeDiameterFraction)
//                    .glassEffect(.regular, in: Circle())
                    .background(.ultraThinMaterial, in: .circle)
                    .overlay(
                        Circle().stroke(style.centerBadgeBorderColor,
                                        lineWidth: style.centerBadgeBorderLineWidth)
                    )
                    
            }
            .frame(width: Constants.arrowContainerSize, height: Constants.arrowContainerSize)
            .padding(Constants.arrowContainerPadding)
        }
        .frame(width: size, height: size)
        .contentShape(Circle())
    }
    
    private func shouldSkipTickForLabels(angleDegrees: Double, clearanceDegrees: Double) -> Bool {
        // цільові кути для підписів
        let targets: [Double] = [0, 90, 180, 270]
        return targets.contains { angularDistanceDegrees(angleDegrees, $0) <= clearanceDegrees }
    }

    private func angularDistanceDegrees(_ a: Double, _ b: Double) -> Double {
        let aN = (a.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        let bN = (b.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        let diff = abs(aN - bN)
        return min(diff, 360 - diff)
    }
}

#Preview {
    CompassView(
        directionDegrees: 185,
        windSpeed: .init(value: 4.8, unit: .metersPerSecond),
        size: 128
    )
}
