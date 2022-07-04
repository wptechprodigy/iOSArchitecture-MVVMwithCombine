//
//  FavoriteViewController.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import UIKit
import Combine

class FavoriteViewController: UITableViewController {

    // MARK: - Subscriptions

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Dependencies

    private var viewModel: FavoriteSongViewModel!

    // MARK: - Constants

    private let rowHeight: CGFloat = 80.0

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
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
    }

    // MARK: - Datasource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.songResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath)
    }

    // MARK: - Delegates

    override func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? FavoriteCell else {
            print("Error trying to display a custom cell")
            return
        }
        let favoriteSong = viewModel.songResults[indexPath.row]
        cell.configureCell(with: favoriteSong)
    }
}