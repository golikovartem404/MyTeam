//
//  PhoneView.swift
//  MyTeam
//
//  Created by User on 23.11.2022.
//

import UIKit

final class PhoneView: BaseView {

    // MARK: - Constants

    private enum Constants {

        enum View {
            static let width: CGFloat = UIScreen.main.bounds.width
            static let height: CGFloat = 73.5
        }

        enum Image {
            static let leading: CGFloat = 20
        }

        enum Button {
            static let font = Resources.Fonts.interMedium(with: 16)
            static let trailig: CGFloat = 14
        }
    }

    // MARK: - Views

    let phoneButton = PhoneView.makePhoneButton()

    private let phoneImageView = PhoneView.makePhoneImageView()
    private let phoneView = UIView(frame: CGRect(x: .zero, y: .zero,
                                                 width: Constants.View.width,
                                                 height: Constants.View.height))

    // MARK: - Setting View

    override func setViewPosition() {
        [phoneView, phoneImageView, phoneButton].forEach { addSubview($0) }
        [phoneImageView, phoneButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            phoneImageView.centerYAnchor.constraint(equalTo: phoneView.centerYAnchor),
            phoneImageView.leadingAnchor.constraint(equalTo: phoneView.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: Constants.Image.leading),

            phoneButton.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor),
            phoneButton.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor,
                                                 constant: Constants.Button.trailig)
        ])
    }
}

// MARK: - Set Data Methods

extension PhoneView {

    func setData(phoneNumber: String) {
        phoneButton.setTitle(phoneNumber, for: .normal)
    }
}

// MARK: - Created SubViews

private extension PhoneView {

    static func makePhoneImageView() -> UIImageView {
        let phoneImageView = UIImageView()
        phoneImageView.image = Resources.Images.Profile.phone
        return phoneImageView
    }

    static func makePhoneButton() -> UIButton {
        let phoneButton = UIButton(type: .system)

        phoneButton.setTitleColor(Resources.Colors.Text.active, for: .normal)
        phoneButton.setTitleColor(Resources.Colors.Text.inActive, for: .highlighted)
        phoneButton.isHidden = false
        phoneButton.titleLabel?.font = Constants.Button.font

        return phoneButton
    }
}
