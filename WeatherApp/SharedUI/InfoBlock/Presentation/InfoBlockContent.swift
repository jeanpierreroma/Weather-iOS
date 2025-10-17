//
//  InfoBlockContent.swift
//  WeatherApp
//
//  Created by Oleksandr Melnechenko on 13.10.2025.
//


import SwiftUI

protocol InfoBlockContent: View {
    var header: String { get }
    var headerIconSystemName: String { get }
}