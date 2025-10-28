//
//  ChartBand.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 28.10.2025.
//

import Foundation
import SwiftUI

struct ChartBand: Identifiable, Hashable {
    let id: String
    let range: ClosedRange<Double>
    let color: Color
    
    init(_ range: ClosedRange<Double>, color: Color, id: String? = nil) {
        self.range = range
        self.color = color
        self.id = id ?? "\(range.lowerBound)-\(range.upperBound)"
    }
}
