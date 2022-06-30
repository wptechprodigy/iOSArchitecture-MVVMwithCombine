//
//  MusicSearchRequest.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 29/06/2022.
//

import Foundation

class MusicSearchRequest: RequestProtocol {

    // MARK: - Properties

    var song: String
    var path: String {
        return "/search"
    }
    var parameters: [String : String] {
        return [
            "media": "music",
            "entity": "song",
            "term": song
        ]
    }

    // MARK: - Initializer

    init(song: String = "") {
        self.song = song
    }
}
