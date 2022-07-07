//
//  Section.swift
//  iOSArchitecture
//
//  Created by waheedCodes on 06/07/2022.
//

import Foundation

struct Section {
    let title: String
    let data: [DataProtocol]

    // MARK: - Data Items

    var numberOfItems: Int {
        return data.count
    }

    subscript(index: Int) -> DataProtocol {
        return data[index]
    }
}

extension Section {
    init(title: String, data: DataProtocol...) {
        self.title = title
        self.data = data
    }
}
