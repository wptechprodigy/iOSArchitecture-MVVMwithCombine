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
        switch viewModel.sections[indexPath.section].title {
            case "Albums":
                return tableView
                    .dequeueReusableCell(
                        withIdentifier: AlbumCell.reuseIdentifier,
                        for: indexPath)
            case "Songs":
                return tableView
                    .dequeueReusableCell(
                        withIdentifier: SongCell.reuseIdentifier,
                        for: indexPath)
            default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }
}
