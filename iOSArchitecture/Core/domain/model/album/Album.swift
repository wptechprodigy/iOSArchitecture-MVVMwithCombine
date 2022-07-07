//
//  Album.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 05/07/2022.
//

import Foundation

struct AlbumList: Decodable {
    let results: [Album]
}

// MARK: - Result
struct Album: Decodable, DataProtocol {
    var artist: String
    let name: String?
    let artworkUrl: String?
    let numberOfTracks: Int?

    enum CodingKeys: String, CodingKey {
        case artist = "artistName"
        case name = "collectionName"
        case artworkUrl = "artworkUrl100"
        case numberOfTracks = "trackCount"
    }
}
