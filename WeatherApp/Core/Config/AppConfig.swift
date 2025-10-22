//
//  AppConfig.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 09.10.2025.
//

import Foundation

struct AppConfig: Equatable {
    enum Environment: String { case dev, staging, prod }

    let env: Environment
    let apiBaseURL: URL
    let mediaBaseURL: URL
    let enableNetworkLogs: Bool
    let enableMockMode: Bool

    // Готові пресети
    static let dev = AppConfig(
        env: .dev,
        apiBaseURL: URL(string: "https://api.open-meteo.com/v1")!,
        mediaBaseURL: URL(string: "http://localhost:9000")!,
        enableNetworkLogs: true,
        enableMockMode: false
    )

    static let staging = AppConfig(
        env: .staging,
        apiBaseURL: URL(string: "https://api-staging.example.com")!,
        mediaBaseURL: URL(string: "https://media-staging.example.com")!,
        enableNetworkLogs: true,
        enableMockMode: false
    )

    static let prod = AppConfig(
        env: .prod,
        apiBaseURL: URL(string: "https://api.example.com")!,
        mediaBaseURL: URL(string: "https://media.example.com")!,
        enableNetworkLogs: false,
        enableMockMode: false
    )
}
