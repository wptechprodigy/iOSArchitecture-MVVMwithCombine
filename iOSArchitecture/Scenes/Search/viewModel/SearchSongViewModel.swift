//
//  SearchSongViewModel.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Combine
import Foundation
import UIKit

class SearchSongViewModel {

    // MARK: - Properties

    private var musicSearchRepository: MusicSearchRepository
    private var subscriptions = Set<AnyCancellable>()

    @Published public var songInput: String = ""
    @Published public private(set) var songResults: [Song] = []

    // MARK: - Initializer

    init(musicSearchRepository: MusicSearchRepository) {
        self.musicSearchRepository = musicSearchRepository
    }

    func start() {
        $songInput
            .sink(receiveValue: searchForSong(_:))
            .store(in: &subscriptions)
    }

    // MARK: - Songs

    private func searchForSong(_ song: String) {
        musicSearchRepository
            .search(song)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] songList in
                    self?.updateSongResult(songList.results)
                })
            .store(in: &subscriptions)
    }

    private func updateSongResult(_ songResults: [Song]) {
        self.songResults = songResults
    }

    // MARK: - Logout

    @objc func logout() {
        
    }
}
