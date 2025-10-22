//
//  HttpClient.swift
//  Instagram
//
//  Created by Oleksandr Melnechenko on 03.10.2025.
//

import Foundation

final class HTTPClient: HTTPClienting {
    private let session: URLSession
    private let baseURL: URL
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder

    init(
        config: APIConfig,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.baseURL = config.baseURL
        self.session = session
        self.jsonDecoder = decoder
        self.jsonEncoder = encoder
        
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder.dateDecodingStrategy = .secondsSince1970
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        self.jsonEncoder.dateEncodingStrategy = .iso8601
        
        session.configuration.httpMaximumConnectionsPerHost = 6
        session.configuration.timeoutIntervalForRequest = 30
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
    }

    func send<Response>(_ endpoint: Endpoint<Response>) async -> Result<Response, NetworkFailure> where Response : Decodable {
        do {
            let request = try makeRequest(for: endpoint)
            
            let (data, resp) = try await session.data(for: request)
            guard let http = resp as? HTTPURLResponse else {
                return .failure(.transportFailure("Bad response type"))
            }
            
            guard (200..<300).contains(http.statusCode) else {
                let preview = String(data: data.prefix(512), encoding: .utf8)
                return .failure(.httpFailure("HTTP error \(http.statusCode), body preview: \(preview ?? "no data")"))
            }
            
            do {
                let response = try jsonDecoder.decode(Response.self, from: data)
                return .success(response)
            } catch {
                return .failure(.decodingFailure("Decoding failed", innerError: error))
            }
        } catch is CancellationError {
            return .failure(.cancelled())
        } catch let nf as NetworkFailure {
            return .failure(nf)
        } catch {
            return .failure(.transportFailure("Unknown error", innerError: error))
        }
    }
    
    private func makeRequest<Response>(for endpoint: Endpoint<Response>) throws -> URLRequest {
        var url = baseURL
        let cleaned = endpoint.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        url.appendPathComponent(cleaned)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw NetworkFailure.invalidURL("Invalid URL components")
        }

        if !endpoint.query.isEmpty { components.queryItems = endpoint.query }
        guard let url = components.url else {
            throw NetworkFailure.invalidURL("Failed to build URL from components")
        }

        var req = URLRequest(url: url)
        req.httpMethod = endpoint.method.rawValue

        // Headers
        var headers = endpoint.headers
        headers["Accept"] = headers["Accept"] ?? "application/json"

        // Body
        if let body = endpoint.body {
            req.httpBody = try jsonEncoder.encode(body)
            headers["Content-Type"] = headers["Content-Type"] ?? "application/json"
        }

        for (k, v) in headers { req.setValue(v, forHTTPHeaderField: k) }
        return req
    }
}
