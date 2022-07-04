//
//  FavoriteSongRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import Foundation
import Combine
import RealmSwift

final class FavoriteSongRepository: FavoriteRepository {

    private let realm: Realm
    
    var token: NotificationToken?
    @Published var favoriteSongs: [Song] = []

    // MARK: - Initializer

    init() {
        realm = try! Realm()
    }

    // MARK: - Load Songs

    func loadAllSong() {
        let objects = realm.objects(StorableSong.self)

        token = objects.observe({ [weak self] changes in
            self?.favoriteSongs = objects.map({ storableSong in
                return storableSong.model
            })
        })
    }

    deinit{
        token?.invalidate()
    }

    // MARK: - Add Song

    func add(song: Song) throws {
        try realm.write({
            realm.add(song.toStorable())
        })
    }

    // MARK: - Delete Song

    func delete(song: Song) throws {
        try realm.write {
            let predicate = NSPredicate(format: "uuid == %@", song.toStorable().uuid)
            if let productToDelete = realm.objects(StorableSong.self)
                .filter(predicate).first {
                realm.delete(productToDelete)
            }
        }
    }
}
