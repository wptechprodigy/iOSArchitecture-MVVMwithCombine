//
//  UIViewController+HideKeyboard.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//
// *******************************************************************************************
//
// → What's This File?
//   It's an extension. This is our logic to dismiss the keyboard when anywhere is tapped
//   on the screen when the keyboard is active.
//
//   Architectural Layer: Presentation Layer
//
// *******************************************************************************************

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
