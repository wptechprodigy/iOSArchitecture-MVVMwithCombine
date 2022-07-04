//
//  Song.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import Foundation

struct SongList: Decodable {
    let results: [Song]
}

struct Song: Decodable, Hashable {
    let name: String
    let songID: Int
    let artist: String
    let previewUrl: String
    
    init(
        name: String,
        songID: Int,
        artist: String,
        previewUrl: String = ""
    ) {
        self.name = name
        self.songID = songID
        self.artist = artist
        self.previewUrl = previewUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case songID = "artistId"
        case artist = "artistName"
        case previewUrl = "previewUrl"
    }
}
