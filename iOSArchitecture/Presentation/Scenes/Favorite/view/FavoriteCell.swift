//
//  FavoriteCell.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 01/07/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // MARK: - Reuse identifier

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - UI Elements

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        contentView.backgroundColor = .systemBackground
        [nameLabel, artistLabel]
            .forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            artistLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            artistLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            artistLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Configure

    func configureCell(with song: Song) {
        nameLabel.text = song.name
        artistLabel.text = song.artist
    }
}
