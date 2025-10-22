//
//  NetworkFailureType.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//

import Foundation

public enum NetworkFailureType {
    case invalidURL
    case http
    case decoding
    case transport
    case cancelled
}
