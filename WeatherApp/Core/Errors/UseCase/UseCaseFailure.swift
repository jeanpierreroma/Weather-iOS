//
//  UseCaseFailure.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

public struct UseCaseFailure: Error, Sendable {
    let failureType: UseCaseFailureType
    let message: String
    let innerError: Error?
    
    public static func networkFailure(_ details: String, innerError: Error? = nil) -> UseCaseFailure {
        UseCaseFailure(failureType: .networkFailure, message: details, innerError: innerError)
    }
    
    public static func repositoryFailure(_ details: String, innerError: Error? = nil) -> UseCaseFailure {
        UseCaseFailure(failureType: .repositoryFailure, message: details, innerError: innerError)
    }
}
