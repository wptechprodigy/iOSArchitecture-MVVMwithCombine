//
//  StorableSong.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 02/07/2022.
//

import Foundation
import RealmSwift

extension Song {
    
    private var storableSong: StorableSong {
        let realmSong = StorableSong()
        realmSong.name = name
        realmSong.songID = songID
        realmSong.artist = artist
        realmSong.previewUrl = previewUrl
        realmSong.uuid = String(songID)
        return realmSong
    }

    func toStorable() -> StorableSong {
        return storableSong
    }
}

class StorableSong: Object, Storable {

    @Persisted var name: String = ""
    @Persisted dynamic var songID: Int = 0
    @Persisted dynamic var artist: String = ""
    @Persisted dynamic var previewUrl: String = ""
    @Persisted dynamic var uuid: String = ""

    var model: Song {
        get {
            return Song(
                name: name,
                songID: songID,
                artist: artist,
                previewUrl: previewUrl
            )
        }
    }
}

