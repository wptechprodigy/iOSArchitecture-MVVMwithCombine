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

    @Published public var songID: Int = 0
    @Published public var message: String = ""
    @Published public private(set) var songResults: [Song] = []

    // MARK: - Initializer

    init(favoriteSongRepository: FavoriteSongRepository) {
        self.favoriteSongRepository = favoriteSongRepository
    }

    // MARK: - Start

    func start() {
        $songID
            .sink(receiveValue: add(_:))
            .store(in: &subscriptions)
    }

    // MARK: - Add

    private func add(_ songID: Int) {
        // TODO: - Add song to data storage
    }

    // MARK: - Load

    func loadFavoriteSongs() {
        // TODO: - Load all song from data storage
    }

    // MARK: - Delete

    func delete(_ songID: Int) {
        // TODO: - Delete song using ID
    }
}
