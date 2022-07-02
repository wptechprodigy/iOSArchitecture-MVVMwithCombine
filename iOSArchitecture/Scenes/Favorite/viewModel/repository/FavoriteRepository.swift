//
//  FavoriteRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import Foundation
import Combine

protocol FavoriteRepository {
    func load() -> AnyPublisher<SongList, Error>
    func delete(_ songID: Int) -> AnyPublisher<String, Error>
    func add(_ songID: Int) -> AnyPublisher<String, Error>
}
