import SwiftUI
import Charts

struct MetricPoint: Identifiable {
    let date: Date
    let value: Double
    var id: Date { date }
}