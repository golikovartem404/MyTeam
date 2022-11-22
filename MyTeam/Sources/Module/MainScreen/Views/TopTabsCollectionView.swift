//
//  TopTabsCollectionView.swift
//  MyTeam
//
//  Created by User on 22.11.2022.
//

import UIKit

final class TopTabsCollectionView: UICollectionView {

    // MARK: - Initialization

    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.init(frame: .zero, collectionViewLayout: layout)

        setViewAppearance()
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private Methods

private extension TopTabsCollectionView {

    func setViewAppearance() {
        showsHorizontalScrollIndicator = false
    }
}
