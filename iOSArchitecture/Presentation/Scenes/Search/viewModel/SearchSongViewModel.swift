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
    private var lookUpAlbumRepository: LookUpAlbumRepository
    private var subscriptions = Set<AnyCancellable>()

    @Published public var songInput: String = ""
    @Published public private(set) var songResults: [Song] = []
    @Published public private(set) var albumResults: [Album] = []

    // MARK: - Initializer

    init(musicSearchRepository: MusicSearchRepository, lookUpAlbumRepository: LookUpAlbumRepository) {
        self.musicSearchRepository = musicSearchRepository
        self.lookUpAlbumRepository = lookUpAlbumRepository
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
                    if !songList.results.isEmpty {
                        let songID = songList.results[0].songID
                        switch self?.checkIfSearchTermIsArtistNameOrSongTitle(songList.results) {
                            case true:
                                self?.lookupAlbum(songID)
                                self?.updateSongResult(songList.results)
                            case false:
                                self?.updateSongResult(songList.results)
                            default:
                                break
                        }
                    }
                })
            .store(in: &subscriptions)
    }

    // MARK: - LookUp Album

    private func lookupAlbum(_ songID: Int) {
        lookUpAlbumRepository
            .lookup(songID)
            .print()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] albumList in
                    self?.updateAlbumResult(albumList.results)
                })
            .store(in: &subscriptions)
    }

    // MARK: - Update

    private func updateSongResult(_ songResults: [Song]) {
        self.songResults = songResults
    }

    private func updateAlbumResult(_ albumResults: [Album]) {
        self.albumResults = albumResults
    }

    // MARK: - Artist or Song

    private func checkIfSearchTermIsArtistNameOrSongTitle(_ result: [Song]) -> Bool {
        let numberWantedChecks = 5
        var count = 1
        var numberFound = 0

        while count <= numberWantedChecks {
            let currentSongID = result[count - 1].songID
            let nextSongID = result[count].songID

            if currentSongID != nextSongID {
                break
            }

            numberFound += 1
            count += 1
        }

        return numberFound == numberWantedChecks
    }
}
