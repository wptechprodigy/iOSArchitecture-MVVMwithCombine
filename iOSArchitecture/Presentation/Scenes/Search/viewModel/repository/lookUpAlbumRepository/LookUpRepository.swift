//
//  LookUpRepository.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 05/07/2022.
//

import Foundation
import Combine

protocol LookUpRepository {
    func lookup(_ album: String) -> AnyPublisher<AlbumList, Error>
}
