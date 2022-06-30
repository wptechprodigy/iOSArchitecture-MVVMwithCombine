//
//  MusicSearchRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation
import Combine

class MusicSearchRepository: SearchRepository {

    // MARK: - Properties

    private var musicSearchRequest: MusicSearchRequest
    private var musicNetworkManager: MusicNetworkManager

    // MARK: - Initializers

    init(musicSearchRequest: MusicSearchRequest, musicNetworkManager: MusicNetworkManager) {
        self.musicSearchRequest = musicSearchRequest
        self.musicNetworkManager = musicNetworkManager
    }

    // MARK: - Search

    func search(_ song: String) -> AnyPublisher<SongList, Error> {
        musicSearchRequest.song = song
        let request = try! musicSearchRequest.createURLRequest()
        return musicNetworkManager.search(request)
    }
}
