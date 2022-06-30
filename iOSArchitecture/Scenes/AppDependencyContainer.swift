//
//  AppDependencyContainer.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//

import UIKit

final class AppDependencyContainer {

    // MARK: - dependency Containers

    let signInDependencyContainer: SignInDependencyContainer
    let searchDependencyContainer: SearchDependencyContainer

    // MARK: - Initializer

    init() {
        self.signInDependencyContainer = SignInDependencyContainer()
        self.searchDependencyContainer = SearchDependencyContainer()
    }

    // MARK: - Navigation

    private func makeNavigationController(_ rootViewController: UIViewController) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.backgroundColor = .systemBackground
        navigationController.navigationBar.isTranslucent = true
        navigationController.modalPresentationStyle = .fullScreen

        return navigationController
    }

    // MARK: - Intial Scene
    
    func makeInitialIntialAppScene() -> SignInViewController {
        let searchViewController = searchDependencyContainer.makeSearchViewController()
        let navigationController = makeNavigationController(searchViewController)
        return signInDependencyContainer.makeSignInViewController(navigationController)
    }
}
