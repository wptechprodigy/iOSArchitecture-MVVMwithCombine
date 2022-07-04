//
//  SearchRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation
import Combine

protocol SearchRepository {
    func search(_ song: String) -> AnyPublisher<SongList, Error>
}
