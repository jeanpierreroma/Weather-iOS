import SwiftUI

struct HourForecastPoint: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let celsius: Double
    let symbol: String
}