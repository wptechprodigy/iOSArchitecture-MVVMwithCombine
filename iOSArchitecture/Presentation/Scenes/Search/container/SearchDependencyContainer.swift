//
//  SearchDependencyContainer.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//

import UIKit

final class SearchDependencyContainer {
    
    private func makeMusicNetworkManager() -> MusicNetworkManager {
        return MusicNetworkManager()
    }

    private func makeMusicSearchRequest() -> MusicSearchRequest {
        return MusicSearchRequest()
    }

    private func makeMusicSearchRepository() -> MusicSearchRepository {
        let musicSearchRequest = makeMusicSearchRequest()
        let musicNetworkManager = makeMusicNetworkManager()

        return MusicSearchRepository(
            musicSearchRequest: musicSearchRequest,
            musicNetworkManager: musicNetworkManager)
    }

    private func makeSearchSongViewModel() -> SearchSongViewModel {
        let musicSearchRepository = makeMusicSearchRepository()
        return SearchSongViewModel(musicSearchRepository: musicSearchRepository)
    }

    // MARK: - Final Object

    func makeSearchViewController() -> SearchViewController {
        let searchSongViewModel = makeSearchSongViewModel()
        return SearchViewController(viewModel: searchSongViewModel)
    }
}
