import SwiftUI

struct TemperatureBar: View {
    let lowestTemperatureText: String
    let highestTemperatureText: String
    let lowestTemperature: Double
    let highestTemperature: Double
    
    var barWidth: CGFloat = 100
    var labelWidth: CGFloat?
    
    var body: some View {
        HStack(spacing: 4) {
            Text(lowestTemperatureText)
                .font(.body)
                .monospacedDigit()
                .lineLimit(1)
                .frame(width: labelWidth, alignment: .trailing)

            LinearGradientScaleBar(
                totalRange: lowestTemperature...highestTemperature,
                colorStops: [
                    (-40, .purple), (-20, .blue), (0, .cyan),
                    (10, .green), (20, .yellow), (30, .orange), (55, .red)
                ],
                barStyle: .init(barHeight: 6, cornerRadius: 3),
                value: 0,
                indicatorStyle: .init(
                    color: .white, diameter: 6, shadowRadius: 2, shadowOpacity: 0.45
                )
            )
            .frame(width: barWidth, height: 6)

            Text(highestTemperatureText)
                .font(.body)
                .monospacedDigit()
                .lineLimit(1)
                .frame(width: labelWidth, alignment: .trailing)
        }
    }
}