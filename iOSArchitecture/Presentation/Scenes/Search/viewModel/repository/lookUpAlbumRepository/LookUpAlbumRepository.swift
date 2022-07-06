//
//  LookUpAlbumRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 05/07/2022.
//

import Foundation
import Combine

class LookUpAlbumRepository: LookUpRepository {

    // MARK: - Properties

    private var lookUpAlbumRequest: LookUpAlbumRequest
    private var lookUpAlbumNetworkManager: LookUpAlbumNetworkManager

    // MARK: - Initializers

    init(lookUpAlbumRequest: LookUpAlbumRequest,
         lookUpAlbumNetworkManager: LookUpAlbumNetworkManager) {
        self.lookUpAlbumRequest = lookUpAlbumRequest
        self.lookUpAlbumNetworkManager = lookUpAlbumNetworkManager
    }

    // MARK: - Search

    func lookup(_ album: Int) -> AnyPublisher<AlbumList, Error> {
        lookUpAlbumRequest.artistID = album
        let request = try! lookUpAlbumRequest.createURLRequest()
        return lookUpAlbumNetworkManager.lookup(request)
    }
}

