//
//  WindProps.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 17.10.2025.
//


import SwiftUI

public struct WindProps: Sendable {
    public let windText: String
    public let gustText: String
    public let directionText: String
    public let directionDegrees: Double
    public let windForCompass: Measurement<UnitSpeed>
}