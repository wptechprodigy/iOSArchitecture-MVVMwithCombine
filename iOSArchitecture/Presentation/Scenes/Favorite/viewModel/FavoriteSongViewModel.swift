//
//  FavoriteSongViewModel.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import Foundation
import Combine

class FavoriteSongViewModel {

    // MARK: - Dependencies

    private var favoriteSongRepository: FavoriteSongRepository
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Properties

    @Published public var message: String = ""
    @Published public private(set) var songResults: [Song] = []

    // MARK: - Initializer

    init(favoriteSongRepository: FavoriteSongRepository) {
        self.favoriteSongRepository = favoriteSongRepository
        favoriteSongRepository.loadAllSong()

        favoriteSongRepository
            .$favoriteSongs
            .map { Set($0) }
            .map { Array($0) }
            .map(sort)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] songs in
                self?.songResults = songs
            }
            .store(in: &subscriptions)
    }

    private func sort(_ songResults: [Song]) -> [Song] {
        return songResults.sorted(by: {
            $0.name < $1.name
        })
    }

    // MARK: - Add

    func add(_ song: Song) {
        try? favoriteSongRepository.add(song: song)
    }

    // MARK: - Delete

    func delete(_ song: Song) {
        try? favoriteSongRepository.delete(song: song)
    }
}
