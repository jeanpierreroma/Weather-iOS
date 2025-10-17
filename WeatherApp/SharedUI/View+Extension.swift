//
//  View+Extension.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

extension View {
    func metricValueStyle() -> some View { modifier(MetricValueStyle()) }
    func metricCaptionStyle() -> some View { modifier(MetricCaptionStyle()) }
}
