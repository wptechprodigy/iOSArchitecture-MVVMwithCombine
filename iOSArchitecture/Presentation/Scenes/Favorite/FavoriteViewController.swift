//
//  FavoriteViewController.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import UIKit
import Combine
import AVKit

class FavoriteViewController: UITableViewController {

    // MARK: - Subscriptions

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Dependencies

    private var viewModel: FavoriteSongViewModel!
    private var playerViewController = AVPlayerViewController ()

    // MARK: - Constants

    private let rowHeight: CGFloat = 80.0

    // MARK: - Properties

    private lazy var logoutBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Logout"
        barButton.tintColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        barButton.target = self
        barButton.action = #selector(self.logout)
        return barButton
    }()

    // MARK: - Initializer

    convenience init(viewModel: FavoriteSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        tableView.register(FavoriteCell.self,
                           forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        reloadTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTable()
    }

    private func reloadTable() {
        viewModel
            .$songResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }

    // MARK: - Navigation

    private func setupNavigation() {
        navigationItem.title = "Favorites"
        navigationItem.rightBarButtonItem = logoutBarButton
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
    }

    // MARK: - Logout

    @objc func logout() {
        dismiss(animated: true) { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}

    // MARK: - Datasource
extension FavoriteViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath)
    }
}

    // MARK: - Delegates

extension FavoriteViewController {

    override func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let song = viewModel.songResults[indexPath.row]

        playDownload(song)
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FavoriteCell else {
            print("Error trying to display a custom cell")
            return
        }
        let favoriteSong = viewModel.songResults[indexPath.row]
        cell.configureCell(with: favoriteSong)
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: nil) { [weak self] (_, _, _) in
                if let selectedFavoriteSong = self?.viewModel.songResults[indexPath.row] {
                    self?.viewModel.delete(selectedFavoriteSong)
                }
            }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let config = UISwipeActionsConfiguration(actions: [deleteAction])
        config.performsFirstActionWithFullSwipe = true
        return config
    }
}
