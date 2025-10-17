//
//  MetricCaptionStyle.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//


import SwiftUI

struct MetricCaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}