//
//  FavoriteRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import Foundation
import Combine

protocol FavoriteRepository {
    func loadAllSong()
    func delete(song: Song) throws
    func add(song: Song) throws
}

extension FavoriteRepository {
    func loadAllSong() {
        return loadAllSong()
    }
}

protocol Storable {
    var model: Song { get }
    var uuid: String { get }
}

