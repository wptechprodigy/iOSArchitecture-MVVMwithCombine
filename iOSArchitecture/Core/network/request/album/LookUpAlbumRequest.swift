//
//  LookUpAlbumRequest.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 05/07/2022.
//

import Foundation

class LookUpAlbumRequest: RequestProtocol {

    // MARK: - Properties

    var artistID: Int
    var path: String {
        return "/lookup"
    }
    var parameters: [String : String] {
        return [
            "id": "\(artistID)",
            "entity": "album"
        ]
    }

    // MARK: - Initializer

    init(artistID: Int = 0) {
        self.artistID = artistID
    }
}
