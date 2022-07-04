//
//  FavoriteSongsDependencyContainer.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 02/07/2022.
//

import Foundation

final class FavoriteSongsDependencyContainer {

    // MARK: - Favorite ViewModel

    func makeFavoriteSongViewModel() -> FavoriteSongViewModel {
        let favoriteSongRepository = FavoriteSongRepository()
        return FavoriteSongViewModel(favoriteSongRepository: favoriteSongRepository)
    }

    // MARK: - Final Object

    func makeFavoriteSongsController() -> FavoriteViewController {
        let favoriteSongViewModel = makeFavoriteSongViewModel()
        return FavoriteViewController(viewModel: favoriteSongViewModel)
    }
}
