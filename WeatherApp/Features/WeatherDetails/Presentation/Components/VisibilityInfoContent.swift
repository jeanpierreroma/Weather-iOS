//
//  VisibilityInfoContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 16.10.2025.
//

import SwiftUI

struct VisibilityInfoContent: InfoBlockContent {
    var header = "Visibility"
    var headerIconSystemName = "eye.fill"
    
    let props: VisibilityProps
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(props.valueText)
                .metricValueStyle()

            Spacer()
            
            Text(props.summaryText)
                .metricCaptionStyle()
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.indigo, .purple, .pink],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .ignoresSafeArea()

        InfoBlock(content: VisibilityInfoContent(props: .init(valueText: "17", summaryText: "Perfectly clear view.")))
            .padding()
    }
}
