//
//  SmallInfoBlock.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 11.07.2025.
//


import SwiftUI

struct InfoBlock<Content: InfoBlockContent>: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let content: Content
    var appearance: InfoBlockAppearance = .default

    private var cardShape: some InsettableShape {
        RoundedRectangle(cornerRadius: appearance.cornerRadius, style: .continuous)
    }
    private var resolvedBorderColor: Color {
        colorScheme == .dark ? appearance.borderColorForDarkMode : appearance.borderColorForLightMode
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: content.headerIconSystemName).imageScale(.medium)
                Text(content.header).font(.headline)
            }
            
            content
            
        }
        .padding(appearance.contentPadding)
        .frame(
            maxWidth: .infinity,
            minHeight: appearance.fixedHeight,
            maxHeight: appearance.fixedHeight + appearance.contentPadding / 2,
            alignment: .topLeading
        )
        .background(.ultraThinMaterial, in: cardShape)
        .clipShape(cardShape)
        .overlay {
            if appearance.showsBorder {
                cardShape.stroke(resolvedBorderColor, lineWidth: appearance.borderLineWidth)
            }
        }
        .contentShape(cardShape)
    }
}
