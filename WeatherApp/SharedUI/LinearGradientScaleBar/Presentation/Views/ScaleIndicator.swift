//
//  ScaleIndicator.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct ScaleIndicator: View {
    let style: ScaleIndicatorStyle
    
    var body: some View {
        Circle()
            .fill(style.color)
            .frame(width: style.diameter, height: style.diameter)
            .shadow(color: style.color.opacity(style.shadowOpacity),
                    radius: style.shadowRadius)
    }
}

#Preview {
    ScaleIndicator(style: .init(color: .white, diameter: 12, shadowRadius: 2, shadowOpacity: 0.5))
}
