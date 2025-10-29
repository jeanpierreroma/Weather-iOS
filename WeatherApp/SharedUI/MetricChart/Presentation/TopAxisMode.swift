import SwiftUI
import Charts

enum TopAxisMode: Equatable {
    case perHour
    case averageByBucket(hours: Int)
}