//
//  AlbumCell.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 06/07/2022.
//

import UIKit

final class AlbumCell: UITableViewCell {

    // MARK: - UI Elements

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .medium)
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

    // MARK: - Setup UI Elements

    private func setupUI() {
        contentView.backgroundColor = .systemBackground

        [nameLabel, artistLabel]
            .forEach { contentView.addSubview($0) }
        layoutElements()
    }

    private func layoutElements() {
        activateConstraintNameLabel()
        activateConstraintArtistLabel()
    }

    // MARK: - Configure Cell

    func configure(with album: Album) {
        nameLabel.text = album.name
        artistLabel.text = album.artist
    }
}

extension AlbumCell {

    private func activateConstraintNameLabel() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }

    private func activateConstraintArtistLabel() {
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            artistLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor)
        ])
    }
}
