//
//  CompassStyle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 14.10.2025.
//


import SwiftUI

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