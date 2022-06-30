//
//  SignInRootView.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 30/06/2022.
//

import Combine
import UIKit

class SignInRootView: NiblessView {

    // MARK: - Subscriptions

    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Container

    private let contentView: UIView = UIView()

    // MARK: - Constants

    private let message: String = "This small application is made with the MVVM architecture, with the intention of showing how to implement it in an iOS application."

    private var textFieldAttribute: [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
    }

    private var textFieldLeadingPadding: UIView {
        return UIView(frame: .init(x: 0, y: 0, width: 16, height: 44))
    }

    // MARK: - Properties

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Wizeline Music"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36, weight: .medium)
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = message
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        let attributedPlaceholder = NSMutableAttributedString(
            string: "Username", attributes: textFieldAttribute)
        textField.leftView = textFieldLeadingPadding
        textField.leftViewMode = .always
        textField.attributedPlaceholder = attributedPlaceholder
        textField.backgroundColor = .secondarySystemBackground
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.heightAnchor
            .constraint(equalToConstant: 44)
            .isActive = true
        textField.layer.cornerRadius = 22
        textField.layer.masksToBounds = true
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let attributedPlaceholder = NSMutableAttributedString(
            string: "Password", attributes: textFieldAttribute)
        textField.leftView = textFieldLeadingPadding
        textField.leftViewMode = .always
        textField.attributedPlaceholder = attributedPlaceholder
        textField.backgroundColor = .secondarySystemBackground
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.heightAnchor
            .constraint(equalToConstant: 44)
            .isActive = true
        textField.layer.cornerRadius = 22
        textField.layer.masksToBounds = true
        return textField
    }()

    private lazy var inputControlsStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [usernameTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.contentMode = .center
        button.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
        button.setTitle("SIGN IN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 22
        return button
    }()

    // MARK: - Initializer

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
    }

    // MARK: - Lifecycle

    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = .systemBackground

        constructHierarchy()
        activateConstraints()
    }

    // MARK: - Hierarchy

    private func constructHierarchy() {
        [titleLabel, subtitleLabel, inputControlsStackView, loginButton]
            .forEach { contentView.addSubview($0) }
        addSubview(contentView)
    }

    private func activateConstraints() {
        activateConstraintsContentView()
        activateConstraintsTitleLabel()
        activateConstraintsSubtitleLabel()
        activateConstraintsInputControlsStackView()
        activateConstraintsloginButton()
    }
}

// MARK: - Bind ViewModel to View

extension SignInRootView {

    func wireControllerToViewModel(_ viewModel: SignInViewModel) {

        loginButton
            .addTarget(
                viewModel,
                action: #selector(viewModel.signIn),
                for: .touchUpInside)

        bindTextFieldsToViewModel(viewModel)
    }

    private func bindTextFieldsToViewModel(_ viewModel: SignInViewModel) {

        usernameTextField
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.username, on: viewModel)
            .store(in: &subscriptions)

        passwordTextField
            .publisher(for: \.text)
            .map { $0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
}

// MARK: - Constraints

extension SignInRootView {

    private func activateConstraintsContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false

        let width = contentView.widthAnchor
            .constraint(equalTo: layoutMarginsGuide.widthAnchor)
        let leading = contentView.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        let top = contentView.topAnchor
            .constraint(equalTo: layoutMarginsGuide.topAnchor)
        let bottom = contentView.bottomAnchor
            .constraint(equalTo: layoutMarginsGuide.bottomAnchor)

        NSLayoutConstraint.activate(
            [width, leading, trailing, top, bottom]
        )
    }
    private func activateConstraintsTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let leading = titleLabel.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 4)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: titleLabel.trailingAnchor, constant: 4)
        let top = titleLabel.topAnchor
            .constraint(equalTo: contentView.topAnchor, constant: 60)
        let centerX = titleLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)

        NSLayoutConstraint.activate(
            [leading, trailing, top, centerX]
        )
    }
    private func activateConstraintsSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false

        let leading = subtitleLabel.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 38)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: subtitleLabel.trailingAnchor, constant: 38)
        let top = subtitleLabel.topAnchor
            .constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        let centerX = subtitleLabel.centerXAnchor
            .constraint(equalTo: contentView.centerXAnchor)
        NSLayoutConstraint.activate(
            [leading, trailing, top, centerX]
        )
    }
    private func activateConstraintsInputControlsStackView() {
        inputControlsStackView.translatesAutoresizingMaskIntoConstraints = false

        let leading = inputControlsStackView.leadingAnchor
            .constraint(equalTo: contentView.leadingAnchor, constant: 36)
        let trailing = contentView.trailingAnchor
            .constraint(equalTo: inputControlsStackView.trailingAnchor, constant: 36)
        let top = inputControlsStackView.topAnchor
            .constraint(equalTo: subtitleLabel.bottomAnchor, constant: 80)
        NSLayoutConstraint.activate(
            [leading, trailing, top]
        )
    }
    private func activateConstraintsloginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        let height = loginButton.heightAnchor
            .constraint(equalToConstant: 44)
        let leading = loginButton.leadingAnchor
            .constraint(equalTo: inputControlsStackView.leadingAnchor)
        let trailing = loginButton.trailingAnchor
            .constraint(equalTo: inputControlsStackView.trailingAnchor)
        let top = loginButton.topAnchor
            .constraint(equalTo: inputControlsStackView.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate(
            [height, leading, trailing, top]
        )
    }
}
