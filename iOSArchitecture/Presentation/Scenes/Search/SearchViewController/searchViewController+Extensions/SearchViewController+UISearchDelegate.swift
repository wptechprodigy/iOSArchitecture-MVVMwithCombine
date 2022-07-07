//
//  SearchViewController+UISearchDelegate.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 07/07/2022.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            searchController.dismiss(animated: true)
            viewModel.songInput = searchTerm
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.songInput =  ""
    }
}

