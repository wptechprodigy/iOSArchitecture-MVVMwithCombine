//
//  APIManagerProtocol.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher
}

extension APIManagerProtocol {
    func perform(_ session: URLSession, request: URLRequest) -> URLSession.DataTaskPublisher {
        return session.dataTaskPublisher(for: request)
    }
}

class APIManager: APIManagerProtocol {}
