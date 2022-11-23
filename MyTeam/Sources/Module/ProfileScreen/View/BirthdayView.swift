//
//  BirthdayView.swift
//  MyTeam
//
//  Created by User on 23.11.2022.
//

import UIKit

final class BirthdayView: BaseView {

    // MARK: - Constants

    private enum Constants {

        static let textFont = Resources.Fonts.interMedium(with: 16)
        static let imageLeading: CGFloat = 20
        static let birhLeading: CGFloat = 14
        static let yearsTrailing: CGFloat = -20

        enum View {
            static let widht: CGFloat = UIScreen.main.bounds.width
            static let height: CGFloat = 73.5
        }

        enum Line {
            static let top: CGFloat = 27.5
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let width: CGFloat = UIScreen.main.bounds.size.width - 32.0
            static let height: CGFloat = 0.5
        }
    }

    // MARK: - Views

    private let starImageView = BirthdayView.makeStarImageView()
    private let birthDataLabel = BirthdayView.makeBirthDataLabel()
    private let yearsLabel = BirthdayView.makeYearsLabel()
    private let dividingLine = BirthdayView.makeDividingLine()
    private let birthView = UIView(frame: CGRect(x: .zero,
                                                 y: .zero,
                                                 width: Constants.View.widht,
                                                 height: Constants.View.height))

    // MARK: - Setting View

    override func setViewPosition() {

        [birthView, starImageView, birthDataLabel, yearsLabel, dividingLine].forEach { addSubview($0) }
        [starImageView, birthDataLabel, yearsLabel, dividingLine].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            starImageView.centerYAnchor.constraint(equalTo: birthView.centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                   constant: Constants.imageLeading),

            birthDataLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            birthDataLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor,
                                                    constant: Constants.birhLeading),

            yearsLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            yearsLabel.trailingAnchor.constraint(equalTo: birthView.trailingAnchor,
                                                 constant: Constants.yearsTrailing),

            dividingLine.topAnchor.constraint(equalTo: yearsLabel.bottomAnchor, constant: Constants.Line.top),
            dividingLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Line.leading),
            dividingLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Line.trailing),
            dividingLine.widthAnchor.constraint(equalToConstant: Constants.Line.width),
            dividingLine.heightAnchor.constraint(equalToConstant: Constants.Line.height)
        ])
    }
}

// MARK: - Set Data

extension BirthdayView {

    func setData(dateBirth: String, years: String) {
        self.birthDataLabel.text = "\(dateBirth)"
        self.yearsLabel.text = "\(years)"
    }
}

// MARK: - Created SubViews

private extension BirthdayView {

    static func makeStarImageView() -> UIImageView {
        let starImageView = UIImageView()
        starImageView.image = Resources.Images.Profile.start
        return starImageView
    }

    static func makeBirthDataLabel() -> UILabel {
        let birthDataLabel = UILabel()

        birthDataLabel.textColor = Resources.Colors.Text.active
        birthDataLabel.font = Constants.textFont

        return birthDataLabel
    }

    static func makeYearsLabel() -> UILabel {
        let yearsLabel = UILabel()

        yearsLabel.textColor = Resources.Colors.Text.inActive
        yearsLabel.font = Constants.textFont

        return yearsLabel
    }

    static func makeDividingLine() -> UIView {
        let dividingLine = UIView(frame: .zero)
        dividingLine.backgroundColor = Resources.Colors.separator
        return dividingLine
    }
}
