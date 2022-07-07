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

    internal private(set) var viewModel: SearchSongViewModel!
    internal var playerViewController = AVPlayerViewController ()

    // MARK: - Constants

    internal let rowHeight: CGFloat = 70.0

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

    internal lazy var searchController: UISearchController = {
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
        tableView.register(AlbumCell.self,
                           forCellReuseIdentifier: AlbumCell.reuseIdentifier)

        listenToSongResults()
        listenToAlbumResults()
        viewModel.start()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Observer

    private func listenToSongResults() {
        viewModel
            .$songResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }

    private func listenToAlbumResults() {
        viewModel
            .$albumResults
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
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
            self?.navigationController?.popToRootViewController(animated: true)
        }
    }
}
