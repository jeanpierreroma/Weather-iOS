//
//  MetricHeader.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 29.10.2025.
//

import SwiftUI

struct MetricHeader: View {
    let value: Int
    let unit: String
    
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            (
                Text("\(value) ")
                    .font(.title2.weight(.semibold))
                    .monospacedDigit()
                +
                Text(unit).font(.headline)
            )
            .foregroundStyle(.primary)

            Text(description)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MetricHeader(value: 2, unit: "Low", description: "WHO UV Index (UVI)")
}
