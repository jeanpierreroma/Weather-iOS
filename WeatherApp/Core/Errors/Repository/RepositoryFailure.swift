//
//  RepositoryFailure.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

public struct RepositoryFailure: Error, Sendable {
    let failureType: RepositoryFailureType
    let message: String
    let innerError: Error?
    
    public static func networkFailure(_ details: String, innerError: Error? = nil) -> RepositoryFailure {
        RepositoryFailure(failureType: .networkFailure, message: details, innerError: innerError)
    }
}

extension RepositoryFailure {
    func toUseCaseFailure() -> UseCaseFailure {
        switch self.failureType {
            
        case .networkFailure:
            .networkFailure(self.message, innerError: self.innerError)
        }
    }
}
