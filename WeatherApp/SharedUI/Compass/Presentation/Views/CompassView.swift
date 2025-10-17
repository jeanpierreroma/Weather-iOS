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

    var arrowShowsSourceDirection: Bool = true
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

    private var arrowRotationDegrees: Double {
        let base = normalizedDegrees
        return arrowShowsSourceDirection ? base : (base + 180).truncatingRemainder(dividingBy: 360)
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
                arrowShowsSourceDirection: true,
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
                    .glassEffect(.regular, in: Circle())
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

struct CompassStyle: Sendable {
    // Кільце і тікі
    var ringColor: Color = .secondary.opacity(0.25)
    var ringLineWidth: CGFloat = 1

    var majorTickColor: Color = .secondary.opacity(0.65)
    var mediumTickColor: Color = .secondary.opacity(0.5)
    var minorTickColor: Color = .secondary.opacity(0.35)

    var majorTickLength: CGFloat = 10
    var mediumTickLength: CGFloat = 7
    var minorTickLength: CGFloat = 4
    var tickInnerPadding: CGFloat = 4

    // Підписи сторін світу
    var labelColor: Color = .secondary
    var labelClearanceDegrees: Double = 8
    var labelInset: CGFloat = 11

    // Стрілка (як і було — не чіпаю NeedleView)
    var needleFillColor: Color = .white
    var needleBorderColor: Color = .white.opacity(0.25)
    var needleBorderLineWidth: CGFloat = 0.75
    var needleShadowOpacity: Double = 0.35

    // Центр-кружечок зі швидкістю
    var centerBadgeDiameterFraction: CGFloat = 0.46
    var centerBadgeBorderColor: Color = .white.opacity(0.18)
    var centerBadgeBorderLineWidth: CGFloat = 1
    var centerBadgeTextColor: Color = .white
    var centerBadgeFont: Font = .caption.weight(.semibold)

    static let `default` = CompassStyle()
}

struct ArrowWithCenterBadge<CenterContent: View>: View {
    private let headLength: CGFloat = 20
    private let baseShaftLength: CGFloat = 128
    
    // Орієнтація
    let directionDegrees: Double
    var arrowShowsSourceDirection: Bool = true

    // Центр-бейдж
    let centerBadgeDiameter: CGFloat
    let gapBetweenBadgeAndArrow: CGFloat

    // Геометрія стрілки
    let shaftWidth: CGFloat
    /// Частка довжини стрілки, що припадає на наконечник (0.15...0.4)
    let headLengthFraction: CGFloat
    /// Множник ширини наконечника відносно товщини стрижня (1.4...3.0)
    let headWidthMultiplier: CGFloat

    // Стиль
    let arrowFill: Color
    let arrowStroke: Color
    let arrowStrokeLineWidth: CGFloat

    // Контент у центрі
    @ViewBuilder var centerContent: () -> CenterContent

    init(
        directionDegrees: Double,
        arrowShowsSourceDirection: Bool,
        centerBadgeDiameter: CGFloat,
        gapBetweenBadgeAndArrow: CGFloat,
        shaftWidth: CGFloat,
        headLengthFraction: CGFloat,
        headWidthMultiplier: CGFloat,
        arrowFill: Color,
        arrowStroke: Color,
        arrowStrokeLineWidth: CGFloat,
        @ViewBuilder centerContent: @escaping () -> CenterContent
    ) {
        self.directionDegrees = directionDegrees
        self.arrowShowsSourceDirection = arrowShowsSourceDirection
        self.centerBadgeDiameter = centerBadgeDiameter
        self.gapBetweenBadgeAndArrow = gapBetweenBadgeAndArrow
        self.shaftWidth = 4
        self.headLengthFraction = headLengthFraction
        self.headWidthMultiplier = headWidthMultiplier
        self.arrowFill = arrowFill
        self.arrowStroke = arrowStroke
        self.arrowStrokeLineWidth = arrowStrokeLineWidth
        self.centerContent = centerContent
    }

    private var effectiveRotationDegrees: Double {
        arrowShowsSourceDirection ? directionDegrees : (directionDegrees + 180).truncatingRemainder(dividingBy: 360)
    }

    var body: some View {
        GeometryReader { proxy in
            let centerBadgeRadius = centerBadgeDiameter / 2

            let headLength: CGFloat = headLength
            let headWidth: CGFloat = 14

            ZStack {
                // Стрілка
                ArrowPointerShape(
                    distanceFromCenterToShaftBottom: -centerBadgeRadius + 4,
                    shaftLength: 128 - headLength - 8,
                    shaftWidth: shaftWidth,
                    headLength: headLength,
                    headWidth: headWidth
                )
                .fill(arrowFill)
                .rotationEffect(.degrees(effectiveRotationDegrees))
                
                centerContent()
                    .frame(width: centerBadgeDiameter, height: centerBadgeDiameter)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ArrowPointerShape: Shape {
    let distanceFromCenterToShaftBottom: CGFloat
    let shaftLength: CGFloat
    let shaftWidth: CGFloat
    let headLength: CGFloat
    let headWidth: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let centerX = rect.midX
        let centerY = rect.midY

        // Базові координати для вертикальної стрілки, що «дивиться» вгору
        let shaftBottomY = centerY - distanceFromCenterToShaftBottom
        let shaftTopY = shaftBottomY - shaftLength
        let headTipY = shaftTopY - headLength

        let startCircleRadius = headWidth / 2
        let startCircleRect = CGRect(
            x: centerX - (startCircleRadius / 1),
            y: shaftBottomY - (startCircleRadius * 2),
            width: startCircleRadius * 2,
            height: startCircleRadius * 2
        )
        path.addEllipse(in: startCircleRect)

        // Стрижень
        let shaftRect = CGRect(
            x: centerX - shaftWidth / 2,
            y: shaftTopY,
            width: shaftWidth,
            height: shaftLength - startCircleRadius
        )
        path.addRoundedRect(in: shaftRect, cornerSize: CGSize(width: shaftWidth / 2, height: shaftWidth / 2))

        // Наконечник (трикутник)
        path.move(to: CGPoint(x: centerX, y: headTipY))
        path.addLine(to: CGPoint(x: centerX - headWidth / 2, y: shaftTopY))
        path.addLine(to: CGPoint(x: centerX + headWidth / 2, y: shaftTopY))
        path.addLine(to: CGPoint(x: centerX, y: headTipY))
        path.closeSubpath()

        return path
    }
}

#Preview {
    CompassView(
        directionDegrees: 185,
        windSpeed: .init(value: 4.8, unit: .metersPerSecond),
        arrowShowsSourceDirection: true,
        size: 128
    )
}
