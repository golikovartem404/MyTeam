//
//  SortViewController.swift
//  MyTeam
//
//  Created by User on 22.11.2022.
//

import UIKit

protocol SortViewDelegate: AnyObject {
    func sortByAlphabet()
    func sortByBirthday()
    func showBirthday(shouldShow: Bool)
}

class SortViewController: BaseViewController<SortView> {

    weak var delegate: SortViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    private func setupActions() {
        mainView.alphabetSortButton.addTarget(
            self,
            action: #selector(self.alphabetSortButtonClicked(_:)),
            for: .touchUpInside
        )
        mainView.birthdaySortButton.addTarget(
            self,
            action: #selector(self.birthdaySortButtonClicked(_:)),
            for: .touchUpInside
        )
    }

    @objc private func alphabetSortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = true
        mainView.birthdaySortButton.isSelected = false
        delegate?.showBirthday(shouldShow: false)
        delegate?.sortByAlphabet()
    }

    @objc private func birthdaySortButtonClicked(_ sender: UIButton) {
        mainView.alphabetSortButton.isSelected = false
        mainView.birthdaySortButton.isSelected = true
        delegate?.showBirthday(shouldShow: true)
        delegate?.sortByBirthday()
    }
}
