//
//  SignInViewModel.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//

import Foundation
import Combine

class SignInViewModel {

    // MARK: - Publisher

    @Published public private(set) var isAuthorised: Bool = false

    // MARK: - Properties

    var username: String = ""
    var password: String = ""

    // MARK: - Bind Login Button

    @objc public func signIn() {

        guard username == Credentials.username.value
                && password == Credentials.password.value else {
            print("Incorrect login credentials. Try again.")
            return
        }
        
        print("Signing in begins...")
        isAuthorised = true
    }
}

// MARK: - Sample Credentials

extension SignInViewModel {
    private enum Credentials {
        case username
        case password

        var value: String {
            switch self {
                case .username:
                    return "waheed"
                case .password:
                    return "password"
            }
        }
    }
}
