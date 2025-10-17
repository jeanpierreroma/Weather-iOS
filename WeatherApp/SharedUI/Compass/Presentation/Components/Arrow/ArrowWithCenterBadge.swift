//
//  ArrowWithCenterBadge.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 14.10.2025.
//


import SwiftUI

struct ArrowWithCenterBadge<CenterContent: View>: View {
    private let headLength: CGFloat = 20
    private let baseShaftLength: CGFloat = 128
    
    // Орієнтація
    let directionDegrees: Double

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
                .rotationEffect(.degrees(directionDegrees))
                
                centerContent()
                    .frame(width: centerBadgeDiameter, height: centerBadgeDiameter)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
