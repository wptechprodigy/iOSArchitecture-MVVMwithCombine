//
//  SearchViewController+TableViewDelegates.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 07/07/2022.
//

import UIKit
import AVKit

extension SearchViewController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return rowHeight
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        switch viewModel.sections[indexPath.section].title {
            case "Albums":
                self.displayAlbumCells(cell, for: indexPath)
            case "Songs":
                self.displaySongCells(cell, for: indexPath)
            default: break
        }
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
            tableView.deselectRow(at: indexPath, animated: true)
            switch viewModel.sections[indexPath.section].title {
                case "Albums":
                    let alert = UIAlertController.alert(with: "Working with mvvm is great!")
                    present(alert, animated: true)
                case "Songs":
                    if let song = viewModel.sections[indexPath.section][indexPath.row] as? Song {
                        playDownload(song)
                    }
                default: break
            }
        }

    private func addToFavorites(_ song: Song) {
        let favoriteViewModel: FavoriteSongViewModel = FavoriteSongsDependencyContainer().makeFavoriteSongViewModel()
        favoriteViewModel.add(song)
    }

    // MARK: - Play Song

    private func playDownload(_ song: Song) {
        present(playerViewController, animated: true) { [weak playerViewController] in
            if let url = URL(string: song.previewUrl) {
                playerViewController?.player = AVPlayer(url: url)
                playerViewController?.player?.play()
            }
        }
    }

    // MARK: - Display Cell

    private func displayAlbumCells(_ cell: UITableViewCell, for indexPath: IndexPath) {
        guard let albumCell = cell as? AlbumCell else {
            print("Error trying to display a custom cell")
            return
        }

        if let data = viewModel.sections[indexPath.section][indexPath.row] as? Album {
            albumCell.configure(with: data)
        }
    }

    private func displaySongCells(_ cell: UITableViewCell, for indexPath: IndexPath) {
        guard let songCell = cell as? SongCell else {
            print("Error trying to display a custom cell")
            return
        }

        if let data = viewModel.sections[indexPath.section][indexPath.row] as? Song {
            songCell.configureUI(with: data)
        }
        songCell.didTapMoreButton = { [weak self] song in
            let alert = UIAlertController.presentOptions(song) { [weak self] song in
                self?.addToFavorites(song)
            }

            self?.present(alert, animated: true)
        }
    }
}
