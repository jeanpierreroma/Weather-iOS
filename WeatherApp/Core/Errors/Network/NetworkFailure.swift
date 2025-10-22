//
//  NetworkFailure.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

import Foundation

public struct NetworkFailure: Error, Sendable {
    let failureType: NetworkFailureType
    let message: String
    let innerError: Error?
    
    public static func invalidURL(_ details: String, innerError: Error? = nil) -> NetworkFailure {
        NetworkFailure(failureType: .invalidURL, message: details, innerError: innerError)
    }
    
    public static func httpFailure(_ details: String, innerError: Error? = nil) -> NetworkFailure {
        NetworkFailure(failureType: .http, message: details, innerError: innerError)
    }
    
    public static func decodingFailure(_ details: String, innerError: Error? = nil) -> NetworkFailure {
        NetworkFailure(failureType: .decoding, message: details, innerError: innerError)
    }
    
    public static func transportFailure(_ details: String, innerError: Error? = nil) -> NetworkFailure {
        NetworkFailure(failureType: .transport, message: details, innerError: innerError)
    }
    
    public static func cancelled() -> NetworkFailure {
        NetworkFailure(failureType: .cancelled, message: "Request was cancelled", innerError: nil)
    }
}

extension NetworkFailure {
    func toRepositoryFailure() -> RepositoryFailure {
        switch self.failureType {
        case .invalidURL:
            .networkFailure(self.message, innerError: self.innerError)
        case .http:
            .networkFailure(self.message, innerError: self.innerError)
        case .decoding:
            .networkFailure(self.message, innerError: self.innerError)
        case .transport:
            .networkFailure(self.message, innerError: self.innerError)
        case .cancelled:
            .networkFailure(self.message, innerError: self.innerError)
        }
    }
}
