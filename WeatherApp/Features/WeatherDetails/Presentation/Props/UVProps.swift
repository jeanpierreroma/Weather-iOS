//
//  UVProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

public struct UVProps: Sendable {
    public let valueText: String
    public let valueNumber: Double
    public let categoryTitle: String
    public let summary: String
    public let colorStops: [(Double, Color)] 
}