import SwiftUI

struct MetricValueStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.weight(.semibold))
            .foregroundStyle(.primary)
            .monospacedDigit()
            .allowsTightening(true)
    }
}