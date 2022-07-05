//
//  MainViewController.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 04/07/2022.
//

import UIKit

class MainViewController: UITabBarController {

    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        setPresentationStyle()
    }

    // MARK: - Presentation

    private func setPresentationStyle() {
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
    }
}
