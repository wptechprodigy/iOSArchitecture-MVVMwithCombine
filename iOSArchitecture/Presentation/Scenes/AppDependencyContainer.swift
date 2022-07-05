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
    let favoriteDependencyContainer: FavoriteSongsDependencyContainer

    // MARK: - Initializer

    init() {
        self.signInDependencyContainer = SignInDependencyContainer()
        self.searchDependencyContainer = SearchDependencyContainer()
        self.favoriteDependencyContainer = FavoriteSongsDependencyContainer()
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

    private func makeSearchFlow() -> UINavigationController {
        let searchViewController = searchDependencyContainer.makeSearchViewController()
        let navigationController = makeNavigationController(searchViewController)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        return navigationController
    }

    private func makeFavoriteFlow() -> UINavigationController {
        let favoriteViewController = favoriteDependencyContainer.makeFavoriteSongsController()
        favoriteViewController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .favorites, tag: 2)
        let favoriteFlow = UINavigationController(rootViewController: favoriteViewController)
        
        return favoriteFlow
    }

    private func makeHomeScene() -> UITabBarController {
        let searchFlow = makeSearchFlow()
        let favoriteFlow = makeFavoriteFlow()

        let homeViewController = MainViewController()
        homeViewController.viewControllers = [searchFlow, favoriteFlow]
        
        return homeViewController
    }

    // MARK: - Intial Scene
    
    func makeSignInFlow() -> SignInViewController {
        let homeScene = makeHomeScene()
        let signInViewController = signInDependencyContainer.makeSignInViewController(homeScene)
        return signInViewController
    }
}
