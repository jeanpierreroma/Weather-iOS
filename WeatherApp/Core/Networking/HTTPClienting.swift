//
//  HTTPClienting.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 08.10.2025.
//


import Foundation

protocol HTTPClienting {
    func send<Response: Decodable>(_ endpoint: Endpoint<Response>) async -> Result<Response, NetworkFailure>
}