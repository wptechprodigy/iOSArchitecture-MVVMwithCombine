//
//  RequestProtocol.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var parameters: [String: String] { get }

    func createURLRequest() throws -> URLRequest
}

extension RequestProtocol {

    private var scheme: String {
        return "https"
    }

    private var host: String {
        return "itunes.apple.com"
    }

    var parameters: [String: String] {
        return [:]
    }

    func createURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        if !parameters.isEmpty {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }

        return URLRequest(url: url)
    }
}
