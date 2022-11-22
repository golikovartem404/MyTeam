//
//  SortViewController.swift
//  MyTeam
//
//  Created by User on 22.11.2022.
//

import UIKit

protocol SortDelegate: AnyObject {

    func sort(model: SortModel)
    func showBirthday(shouldShow: Bool)
}

final class SortViewController: BottomSheetController<SortView> {

    // MARK: - Constants

    private enum Constants {

        static let buttomSheetCornerRadius: CGFloat = 8
    }

    // MARK: - Delegate Properties

    weak var delegate: SortDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredSheetCornerRadius = Constants.buttomSheetCornerRadius
        setTargets()
    }
}

// MARK: - Private Methods

private extension SortViewController {

    func setTargets() {
        selfView.sortButtonArray.forEach { sortButton in
            sortButton.addTarget(self, action: #selector(sortButtonClicked), for: .touchUpInside)
        }
    }
}

// MARK: - Actions

@objc private extension SortViewController {

    func backButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }

    func sortButtonClicked(_ sender: SortButton) {

        selfView.sortButtonArray.forEach { sortButton in
            if sortButton == sender {
                return sortButton.isSelected = true
            }
            sortButton.isSelected = false
        }

        delegate?.showBirthday(shouldShow: sender.model == .birhDate)
        delegate?.sort(model: sender.model)
        dismiss(animated: true)
    }
}
