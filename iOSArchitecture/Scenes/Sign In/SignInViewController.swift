//
//  SignInViewController.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//
// *******************************************************************************************
//
// → What's This File?
//   It's a subclass. This is our sign in view controller.
//
//   Architectural Layer: Presentation Layer
//
// *******************************************************************************************

import UIKit
import Combine

class SignInViewController: NiblessViewController {

    // MARK: - Dependencies

    private var viewModel: SignInViewModel
    private let childViewController: UINavigationController

    // MARK: - Subscriptions

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Initializer

    init(viewModel: SignInViewModel, childViewController: UINavigationController) {
        self.viewModel = viewModel
        self.childViewController = childViewController
        super.init()
    }

    // MARK: - Lifecycle

    override func loadView() {
        super.loadView()
        self.view = SignInRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        subscribe()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let signInRootView = view as? SignInRootView else { return }
        signInRootView.wireControllerToViewModel(viewModel)
    }

    // MARK: - Authorization

    private func subscribe() {
        viewModel
            .$isAuthorised
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                switch result {
                    case true:
                        self?.presentSearchScreen()
                    case false:
                        /* present the login screen */
                        break
                }
            }
            .store(in: &subscriptions)
    }

    // MARK: - Search

    private func presentSearchScreen() {
        present(childViewController, animated: true)
    }
}
