//
//  InfoBlockAppearance.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//


import SwiftUI

struct InfoBlockAppearance: Sendable {
    var cornerRadius: CGFloat = 14
    var verticalPadding: CGFloat = 8
    var horizontalPadding: CGFloat = 14
    var fixedHeight: CGFloat = 160
    
    // Border
    var showsBorder: Bool = true
    var borderLineWidth: CGFloat = 1
    var borderColorForLightMode: Color = .black.opacity(0.08)
    var borderColorForDarkMode: Color  = .white.opacity(0.18)

    static let `default` = InfoBlockAppearance()
}
