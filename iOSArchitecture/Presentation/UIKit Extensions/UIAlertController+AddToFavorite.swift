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

    /// Returns an alert
    /// - Parameter title: Alert title
    /// - Returns: A message alert
    static func alert(_ title: String? = nil, with message: String) -> UIAlertController {
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        alert.addAction(alertAction)

        return alert
    }
}
