import SwiftUI

struct WeatherDataFooter: View {
    var onLearnWeather: () -> Void
    var onLearnMap: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            Text("Learn more about ")
                .foregroundStyle(.secondary)
            + Text("weather data").foregroundStyle(.blue).underline()
            + Text(" and ")
            + Text("map data").foregroundStyle(.blue).underline()

            // tappable areas, if потрібно:
            HStack(spacing: 24) {
                Button("weather data", action: onLearnWeather).buttonStyle(.plain).opacity(0.001)
                Button("map data", action: onLearnMap).buttonStyle(.plain).opacity(0.001)
            }
            .frame(height: 0)
        }
        .font(.footnote)
        .frame(maxWidth: .infinity, alignment: .center)
    }
}