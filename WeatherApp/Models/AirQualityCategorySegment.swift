import SwiftUI

struct AirQualityCategorySegment: Identifiable {
    let identifier = UUID()
    let label: String
    let range: ClosedRange<Double>
    let color: Color
    var id: UUID { identifier }
}