//
//  SearchViewController.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import AVKit
import UIKit
import Combine

class SearchViewController: UIViewController {

    // MARK: - Subscriptions

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Dependencies

    private var viewModel: SearchSongViewModel!
    private var playerViewController = AVPlayerViewController ()

    // MARK: - Constants

    private let rowHeight: CGFloat = 70.0

    // MARK: - Properties

    private var tableFooterView: UIView {
        let tableFooterView = UIView()
        tableFooterView.backgroundColor = .systemBackground
        return tableFooterView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.insetsContentViewsToSafeArea = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.tableFooterView = tableFooterView
        return tableView
    }()

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by song or artist"
        searchController.searchBar.searchTextField.backgroundColor = .secondarySystemBackground
        searchController.searchBar.searchTextField.tintColor = .secondaryLabel
        return searchController
    }()

    private lazy var logoutBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.title = "Logout"
        barButton.tintColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        barButton.target = self
        barButton.action = #selector(self.logout)
        return barButton
    }()

    // MARK: - Initializer

    convenience init(viewModel: SearchSongViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutNavigationItems()
        view.addSubview(tableView)
        tableView.register(SongCell.self,
                           forCellReuseIdentifier: SongCell.reuseIdentifier)

        viewModel
            .$songResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.start()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Navigation Items

    private func layoutNavigationItems() {
        navigationItem.title = "Welcome!"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = logoutBarButton
    }

    // MARK: - Logout

    @objc func logout() {
        dismiss(animated: true) { [weak self] in
            let appNav = AppDependencyContainer().makeInitialIntialAppScene()
            appNav.modalPresentationStyle = .fullScreen
            self?.present(appNav, animated: true)
        }
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
}

// MARK: - TableView Delegate

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        guard
            let songCell = cell as? SongCell
        else {
            print("Error trying to display a custom cell")
            return
        }
        let song = viewModel.songResults[indexPath.row]
        songCell.configureUI(with: song)
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let song = viewModel.songResults[indexPath.row]
            playDownload(song)
        }
}

// MARK: - TableView DataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.songResults.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return tableView
            .dequeueReusableCell(
                withIdentifier: SongCell.reuseIdentifier,
                for: indexPath)
    }
}

// MARK: - Search Delegate

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
