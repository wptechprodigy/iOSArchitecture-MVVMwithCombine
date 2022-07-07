//
//  UIView+ReuseIdentifier.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 06/07/2022.
//

import UIKit

extension UIView {
    
    // MARK: - Reuse identifier

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
