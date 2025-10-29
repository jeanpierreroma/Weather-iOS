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

    @ScaledMetric(relativeTo: .callout) private var barHeight: CGFloat = 22
    @State private var labelWidth: CGFloat = 0
    
    private var progress: CGFloat {
        guard maxValue > 0 else { return 0 }
        return CGFloat((value / maxValue).clamped(to: 0...1))
    }

    var body: some View {
        HStack(spacing: 8) {
            GeometryReader { geo in
                let barWidth = geo.size.width
                let covered = highlight && barWidth * progress > (labelWidth + 10)

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.white)
                        .frame(width: barWidth * progress, height: barHeight)
                        .opacity(highlight ? 1 : 0.45)
                        .animation(.snappy(duration: 0.25, extraBounce: 0.01), value: progress)

                    Text(label)
                        .font(.callout.weight(.semibold))
                        .foregroundStyle(covered ? Color.black : .primary)
                        .padding(.horizontal, 10)
                        .frame(height: barHeight, alignment: .leading)
                        .background(
                            GeometryReader { g in
                                Color.clear
                                    .onAppear { labelWidth = g.size.width }
                                    .onChange(of: g.size) { _, newValue in
                                        labelWidth = newValue.width
                                    }
                            }
                        )
                }
                .frame(height: barHeight, alignment: .leading)
            }
            .frame(height: barHeight)
            .frame(maxWidth: .infinity)

            Text("\(Int(value))")
                .font(.callout.monospacedDigit().weight(.semibold))
                .frame(minWidth: 32, alignment: .trailing)
        }
    }
}

#Preview {
    LabeledBar(label: "Today", value: 7.0, maxValue: 11)
        .background(.ultraThinMaterial)
}
