//
//  LabeledBar.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import SwiftUI

struct LabeledBar: View {
    let label: String
    let value: Double
    let maxValue: Double
    var highlight: Bool = false

    var progress: Double { maxValue > 0 ? min(max(value / maxValue, 0), 1) : 0 }

    var body: some View {
        HStack {
            Text(label).font(.callout.weight(.semibold))
            ZStack(alignment: .leading) {
                Capsule().fill(.white.opacity(0.10))
                GeometryReader { geo in
                    Capsule()
                        .fill(.white)
                        .frame(width: geo.size.width * progress)
                        .opacity(highlight ? 1 : 0.45)
                }
            }
            .frame(height: 14)
            .accessibilityLabel("\(label) \(Int(value))")
            Text("\(Int(value))")
                .font(.callout.monospacedDigit().weight(.semibold))
                .frame(minWidth: 26, alignment: .trailing)
        }
    }
}

#Preview {
    LabeledBar(label: "Today", value: 1.0, maxValue: 11)
}
