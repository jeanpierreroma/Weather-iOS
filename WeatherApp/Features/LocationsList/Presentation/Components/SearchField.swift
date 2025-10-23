//
//  SearchField.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 23.10.2025.
//


import SwiftUI

struct SearchField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField(placeholder, text: $text)
                .textInputAutocapitalization(.words)
                .disableAutocorrection(true)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    @Previewable @State var query = ""
    
    SearchField(text: $query, placeholder: "Search for a city or airport")
        .padding()
}
