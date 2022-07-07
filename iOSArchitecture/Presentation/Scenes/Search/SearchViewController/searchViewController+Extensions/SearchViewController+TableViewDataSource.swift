//
//  SearchViewController+TableViewDataSource.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 07/07/2022.
//

import UIKit

extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.sections[section].numberOfItems
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        if viewModel.sections[indexPath.section].title == "Albums" {
            return tableView
                .dequeueReusableCell(
                    withIdentifier: AlbumCell.reuseIdentifier,
                    for: indexPath)
        } else {
            return tableView
                .dequeueReusableCell(
                    withIdentifier: SongCell.reuseIdentifier,
                    for: indexPath)
        }
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
}
