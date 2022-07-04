//
//  SignInDependencyContainer.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//

import UIKit

final class SignInDependencyContainer {

    // MARK: - SignInViewModel

    private func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel()
    }

    // MARK: - Final Object

    func makeSignInViewController(_ childViewController: UITabBarController) -> SignInViewController {
        let signInViewModel = SignInViewModel()
        return SignInViewController(viewModel: signInViewModel, childViewController: childViewController)
    }
}
