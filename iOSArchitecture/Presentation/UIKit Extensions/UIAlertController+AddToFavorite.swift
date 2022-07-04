//
//  UIAlertController+AddToFavorite.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 04/07/2022.
//

import UIKit

extension UIAlertController {

    /// Builds a menu to present options to selected song to favorites
    /// - Parameter song: Song to be added to favorites
    /// - Returns: An action sheet
    static func presentOptions(_ song: Song, onSelect: @escaping (Song) -> Void) -> UIAlertController {
        let addToFavorite = UIAlertAction(
            title: NSLocalizedString("Add to favorite", comment: "Default action"),
            style: .default) { _ in
                onSelect(song)
            }
        let cancel = UIAlertAction(
            title: NSLocalizedString("Cancel", comment: "Cancel action"),
            style: .cancel)

        let alert = UIAlertController(
            title: nil,
            message: "Add \"\(song.name)\" to your favorites list",
            preferredStyle: .actionSheet)

        alert.addAction(addToFavorite)
        alert.addAction(cancel)

        return alert
    }
}
