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
    let enableNetworkLogs: Bool
    let enableMockMode: Bool

    // Готові пресети
    static let dev = AppConfig(
        env: .dev,
        apiBaseURL: URL(string: "http://localhost:5108/api")!,
        enableNetworkLogs: true,
        enableMockMode: false
    )

    static let staging = AppConfig(
        env: .staging,
        apiBaseURL: URL(string: "http://localhost:5108/api")!,
        enableNetworkLogs: true,
        enableMockMode: false
    )

    static let prod = AppConfig(
        env: .prod,
        apiBaseURL: URL(string: "http://localhost:5108/api")!,
        enableNetworkLogs: false,
        enableMockMode: false
    )
}
