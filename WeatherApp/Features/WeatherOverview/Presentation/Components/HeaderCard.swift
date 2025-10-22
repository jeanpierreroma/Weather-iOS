//
//  HeaderCard.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 10.07.2025.
//

import SwiftUI

private struct HeaderCardContent: View {
    let props: HeaderCardProps
    @Binding var progress: CGFloat
    
    @State private var expandedContentSize: CGSize = .zero
    @State private var collapsedContentSize: CGSize = .init(width: .zero, height: 25)
        
    init(props: HeaderCardProps, progress: Binding<CGFloat>) {
        self.props = props
        self._progress = progress
    }
         
    var body: some View {
        GlassEffectContainer {
            VStack(alignment: .center, spacing: 8) {
                Text(props.cityName)
                    .font(.title.weight(.semibold))
                    .lineLimit(1)
                
                let heightDiff = expandedContentSize.height - collapsedContentSize.height
                let rHeight = heightDiff * collapsedOpacity
                
                ZStack {
                    ExpandedTemperatureInfo(
                        currentTempText: props.currentTempText,
                        additioanlInformation: props.additioanlInformation,
                        highestTemperatureText: props.highestTemperatureText,
                        lowestTemperatureText: props.lowestTemperatureText
                    )
                    .compositingGroup()
                    .opacity(1 - expandedOpacity)
                    .onGeometryChange(for: CGSize.self) {
                        $0.size
                    } action: { newValue in
                        self.expandedContentSize = newValue
                    }
                    .fixedSize()
                    .frame(height: expandedContentSize.height - rHeight)
                    
                    CollapsedTemperatureInfo(
                        currentTempText: props.currentTempText,
                        additioanlInformation: props.additioanlInformation
                    )
                    .compositingGroup()
                    .opacity(collapsedOpacity)
                    .frame(height: collapsedContentSize.height )
                }
                .compositingGroup()
                .clipShape(.rect)
            }
//            .glassEffect(.regular.interactive(), in: .rect)
        }
    }
    
    var expandedOpacity: CGFloat {
        min(progress / 0.35, 1)
    }
    
    var collapsedOpacity: CGFloat {
        max(progress - 0.35, 0) / 0.65
    }
    
    var collapsedScale: CGFloat {
        let minAspectScale = expandedContentSize.height / collapsedContentSize.height
        return minAspectScale + (1 - minAspectScale) * progress
    }
    
    var blurProgress: CGFloat {
        return progress > 0.5 ? (1 - progress) / 0.5 : progress / 0.5
    }
}

struct HeaderCard: View {
    let props: HeaderCardProps
    @Binding var progress: CGFloat
    var mainTempFontSize: CGFloat = 88
    
    init(props: HeaderCardProps, progress: Binding<CGFloat>) {
        self.props = props
        self._progress = progress
    }

    var body: some View {
        HeaderCardContent(
            props: props,
            progress: $progress
        )
    }
}

#Preview {
    @Previewable @State var progress: CGFloat = 0
    
    let props = HeaderCardProps(
        cityName: "Khmelnytskyi",
        currentTempText: "25",
        additioanlInformation: "Sunny",
        highestTemperatureText: "30",
        lowestTemperatureText: "10"
    )
    
    List {
        Section("Preview") {
            HeaderCard(props: props, progress: $progress)
                .padding()
                
        }
        
        Section("Properties") {
            Slider(value: $progress)
        }
    }
}

private struct CollapsedTemperatureInfo: View {
    let currentTempText: String
    let additioanlInformation: String
    
    var body: some View {
        HStack {
            Text(currentTempText)
                .font(.callout)
                .contentTransition(.numericText())
                .lineLimit(1)
                
            Text("|")
                .font(.callout)
            
            Text(additioanlInformation)
                .font(.callout)
        }
    }
}

private struct ExpandedTemperatureInfo: View {
    let currentTempText: String
    let additioanlInformation: String
    let highestTemperatureText: String
    let lowestTemperatureText: String
    
    var body: some View {
        VStack {
            Text(currentTempText)
                .font(.system(size: 88, weight: .thin))
//                .opacity(1 - currentTemperatureOpacity)
                .contentTransition(.numericText())
                .lineLimit(1)
            
            Text(additioanlInformation)
                .font(.callout)
//                .opacity(1 - additionalInfoOpacity)
            
            HStack(spacing: 16) {
                Text("H: \(highestTemperatureText)")
                Text("L: \(lowestTemperatureText)")
            }
            .font(.callout)
//            .opacity(1 - temperatureInfoOpacity)
//            .scaleEffect(1 - 0.05 * temperatureInfoOpacity, anchor: .top)
        }
    }
}

#Preview("CollapsedTemperatureInfo") {
    CollapsedTemperatureInfo(currentTempText: "25", additioanlInformation: "Sunny")
}

#Preview("ExpandedTemperatureInfo") {
    ExpandedTemperatureInfo(
        currentTempText: "25",
        additioanlInformation: "Sunny",
        highestTemperatureText: "30",
        lowestTemperatureText: "20"
    )
}




struct ExpandableGlassMenu<Content: View, Label: View>: View, Animatable {
    var aligment: Alignment
    var cornerRadius: CGFloat = 30
    @Binding var progress: CGFloat
    var labelSize: CGSize = .init(width: 55, height: 55)
    @ViewBuilder var content: Content
    @ViewBuilder var label: Label
    
    @State private var contentSize: CGSize = .zero
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    var body: some View {
        GlassEffectContainer {
            let widthDiff = contentSize.width - labelSize.width
            let heightDiff = contentSize.height - labelSize.height
            
            let rWidth = widthDiff * contentOpacity
            let rHeight = heightDiff * contentOpacity
            
            ZStack(alignment: aligment) {
                content
                    .compositingGroup()
                    .scaleEffect(contentScale)
                    .blur(radius: 14 * blurProgress)
                    .opacity(contentOpacity)
                    .onGeometryChange(for: CGSize.self) {
                        $0.size
                    } action: { newValue in
                        contentSize = newValue
                    }
                    .fixedSize()
                    .frame(width: labelSize.width + rWidth, height: labelSize.height + rHeight)
                
                label
                    .compositingGroup()
                    .blur(radius: 14 * blurProgress)
                    .opacity(1 - labelOpacity)
                    .frame(width: labelSize.width, height: labelSize.height)
            }
            .compositingGroup()
            .clipShape(.rect(cornerRadius: cornerRadius))
            .glassEffect(.regular.interactive(), in: .rect(cornerRadius: cornerRadius))
            .contentShape(.rect)
        }
        .scaleEffect(x: 1 - (blurProgress * 0.35), y: 1 + (blurProgress * 0.45), anchor: scaleAnchor)
        .offset(y: offset * blurProgress)
    }
    
    var labelOpacity: CGFloat {
        min(progress / 0.35, 1)
    }
    
    var contentOpacity: CGFloat {
        max(progress - 0.35, 0) / 0.65
    }
    
    var contentScale: CGFloat {
        let minAspectScale = min(labelSize.width / contentSize.width, labelSize.height / contentSize.height)
        
        return minAspectScale + (1 - minAspectScale) * progress
    }
    
    var blurProgress: CGFloat {
        return progress > 0.5 ? (1 - progress) / 0.5 : progress / 0.5
    }
    
    var offset: CGFloat {
        switch aligment {
        case .bottom, .bottomLeading, .bottomTrailing: return -75
        case .top, .topLeading, .topTrailing: return 75
            
        default: return 0
        }
    }
    
    var scaleAnchor: UnitPoint {
        switch aligment {
        case .bottomLeading: .bottomLeading
        case .bottom: .bottom
        case .bottomTrailing: .bottomTrailing
        case .topTrailing: .topTrailing
        case .top: .top
        case .topLeading: .topLeading
        case .leading: .leading
        case .trailing: .trailing
        default: .center
        }
    }
}
