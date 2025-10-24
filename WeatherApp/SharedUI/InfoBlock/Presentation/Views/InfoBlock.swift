//
//  SmallInfoBlock.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 11.07.2025.
//


import SwiftUI

struct InfoBlock<Content: InfoBlockContent>: View {
    @Environment(\.locale) private var locale
    
    let content: Content
    var appearance: InfoBlockAppearance = .default
    var kind: WeatherKind
    var isNight: Bool

    private var cardShape: some InsettableShape {
        RoundedRectangle(cornerRadius: appearance.cornerRadius)
    }

    var body: some View {
        ZStack {
//            bg.ignoresSafeArea()
            let tint = WeatherColors.color(for: kind, isNight: isNight)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 4) {
                    Image(systemName: content.headerIconSystemName)
                        .imageScale(.small)
                    
                    
                    Text(content.header.uppercased(with: locale))
                        .font(.footnote)
                }
                .opacity(0.65)
                
                content
            }
            .padding(.vertical, appearance.verticalPadding)
            .padding(.horizontal, appearance.horizontalPadding)
    //            .frame(
    //                maxWidth: .infinity,
    //                minHeight: appearance.fixedHeight,
    //                maxHeight: appearance.fixedHeight + appearance.contentPadding / 2,
    //                alignment: .topLeading
    //            )
            .clipShape(cardShape)
            .background(tint.opacity(0.3), in: cardShape)
//            .overlay {
//                cardShape.strokeBorder(tint.opacity(0.35), lineWidth: 1)
//            }
        }
        
    }
}





