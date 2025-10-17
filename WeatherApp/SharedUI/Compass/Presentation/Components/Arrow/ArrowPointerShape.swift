//
//  ArrowPointerShape.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 14.10.2025.
//


import SwiftUI

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