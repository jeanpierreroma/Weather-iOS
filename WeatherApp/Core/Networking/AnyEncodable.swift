//
//  AnyEncodable.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

public struct AnyEncodable: Encodable, Sendable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ value: T) {
        _encode = value.encode
    }
    
    public func encode(to encoder: Encoder) throws { try _encode(encoder) }
}
