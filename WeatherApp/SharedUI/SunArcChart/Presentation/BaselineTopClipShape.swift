//
//  BaselineTopClipShape.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct BaselineTopClipShape: Shape {
    public let baselineFraction: CGFloat
    public func path(in rect: CGRect) -> Path {
        let baselineY = rect.minY + baselineFraction * rect.height
        return Path(CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: Swift.max(0, baselineY - rect.minY)))
    }
}
