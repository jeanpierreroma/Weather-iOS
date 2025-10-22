//
//  HourlyForecastItemView.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 20.10.2025.
//

import SwiftUI

struct HourForecastItem: View {
    let props: HourForecastItemProps
    var labelWidth: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(props.labelText)
                .font(.callout)
                .monospacedDigit()
                .foregroundStyle(.primary)
                .frame(width: labelWidth)
            
            Image(systemName: props.symbolName)
                .imageScale(.large)
                .symbolRenderingMode(.hierarchical)
            
            Text(props.temperatureText)
                .font(.headline)
                .monospacedDigit()
        }
        .padding(.vertical)
        .padding(.horizontal, 10)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    let props = HourForecastItemProps(
        labelText: "12 AM",
        symbolName: "cloud.rain.fill",
        temperatureText: "19°"
    )
    
    HourForecastItem(props: props)
}
