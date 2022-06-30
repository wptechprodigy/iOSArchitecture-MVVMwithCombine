//
//  MusicNetworkManager.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation
import Combine

fileprivate protocol NetworkManagerProtocol {
    var apiManager: APIManagerProtocol { get }

    func search(_ request: URLRequest) -> AnyPublisher<SongList, Error>
}

class MusicNetworkManager: NetworkManagerProtocol {

    // MARK: - Properties

    fileprivate var apiManager: APIManagerProtocol
    private let session: URLSession

    // MARK: - Initializers

    init() {
        self.session = .init(configuration: .default)
        self.apiManager = APIManager()
    }

    init(session: URLSession, apiManager: APIManagerProtocol) {
        self.session = session
        self.apiManager = apiManager
    }

    // MARK: - Decoder

    private var decoder: JSONDecoder {
        return JSONDecoder()
    }

    // MARK: - Search

    func search(_ request: URLRequest) -> AnyPublisher<SongList, Error> {
        return apiManager
            .perform(session, request: request)
            .tryMap { output -> Data in
                return output.data
            }
            .decode(type: SongList.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}
