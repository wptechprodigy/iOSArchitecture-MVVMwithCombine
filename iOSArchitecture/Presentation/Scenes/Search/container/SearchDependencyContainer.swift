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

    private func makeLookUpAlbumNetworkManager() -> LookUpAlbumNetworkManager {
        return LookUpAlbumNetworkManager()
    }

    private func makeLookUpAlbumRequest() -> LookUpAlbumRequest {
        return LookUpAlbumRequest()
    }

    private func makeLookUpAlbumRepository() -> LookUpAlbumRepository {
        let lookUpAlbumRequest = makeLookUpAlbumRequest()
        let lookUpAlbumNetworkManager = makeLookUpAlbumNetworkManager()

        return LookUpAlbumRepository(
            lookUpAlbumRequest: lookUpAlbumRequest,
            lookUpAlbumNetworkManager: lookUpAlbumNetworkManager)
    }



    private func makeSearchSongViewModel() -> SearchSongViewModel {
        let musicSearchRepository = makeMusicSearchRepository()
        let lookUpAlbumRepository = makeLookUpAlbumRepository()
        
        return SearchSongViewModel(musicSearchRepository: musicSearchRepository,
                                   lookUpAlbumRepository: lookUpAlbumRepository)
    }

    // MARK: - Final Object

    func makeSearchViewController() -> SearchViewController {
        let searchSongViewModel = makeSearchSongViewModel()
        return SearchViewController(viewModel: searchSongViewModel)
    }
}
