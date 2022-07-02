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

    // MARK: - Initializer

    convenience init(viewModel: FavoriteSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        viewModel.start()
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
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let subtitleCell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell") else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        }
        return subtitleCell
    }

    // MARK: - Delegates
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = "Row \(indexPath.row)"
        cell.detailTextLabel?.text = "Lorem ipsum dolor sit amet"
    }
}
