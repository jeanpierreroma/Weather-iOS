//
//  SunMarker.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

public struct SunMarker: View {
    public let style: SunMarkerStyle
    public init(style: SunMarkerStyle) { self.style = style }

    public var body: some View {
        Circle()
            .fill(style.color)
            .frame(width: style.diameter, height: style.diameter)
            .shadow(color: style.color.opacity(style.shadowOpacity), radius: style.shadowRadius)
    }
}
