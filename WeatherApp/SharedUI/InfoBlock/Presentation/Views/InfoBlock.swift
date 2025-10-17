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
            
            Spacer(minLength: 0)
        }
        .padding(appearance.contentPadding)
        .frame(
            maxWidth: .infinity,
            minHeight: appearance.fixedHeight,
            maxHeight: appearance.fixedHeight,
            alignment: .topLeading
        )
        .glassEffect(.regular, in: cardShape)
        .overlay {
            if appearance.showsBorder {
                cardShape.stroke(resolvedBorderColor, lineWidth: appearance.borderLineWidth)
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [.indigo, .purple],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .saturation(1.2)
        .brightness(-0.05)
        .ignoresSafeArea()

        GlassEffectContainer {
            VStack(spacing: 16) {
                InfoBlock(header: "Calories", headerIconSystemName: "flame.fill")
                InfoBlock(header: "Protein", headerIconSystemName: "bolt.fill")
                InfoBlock(header: "Water", headerIconSystemName: "drop.fill")
            }
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
