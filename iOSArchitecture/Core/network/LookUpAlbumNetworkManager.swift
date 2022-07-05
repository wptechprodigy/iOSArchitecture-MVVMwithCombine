//
//  LookUpAlbumNetworkManager.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 05/07/2022.
//

import Foundation
import Combine

fileprivate protocol LookUpAlbumManagerProtocol {
    var apiManager: APIManagerProtocol { get }

    func lookup(_ request: URLRequest) -> AnyPublisher<AlbumList, Error>
}

class LookUpAlbumNetworkManager: LookUpAlbumManagerProtocol {

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

    func lookup(_ request: URLRequest) -> AnyPublisher<AlbumList, Error> {
        return apiManager
            .perform(session, request: request)
            .tryMap { output -> Data in
                return output.data
            }
            .decode(type: AlbumList.self, decoder: decoder)
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
}

