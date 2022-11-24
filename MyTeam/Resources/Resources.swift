//
//  Resources.swift
//  MyTeam
//
//  Created by User on 22.11.2022.
//

import UIKit

enum Resources {

    enum Images {
        static let stopper = UIImage(named: "goose")
        static let backArrow = UIImage(named: "back-arrow")
        static let nlo = UIImage(named: "NLO")
        static let loupe = UIImage(named: "loupe")

        enum Profile {
            static let start = UIImage(named: "star")
            static let phone = UIImage(named: "phone")
        }

        enum SearchBar {
            static let clear = UIImage(named: "x-clear")
            static let leftImageNormal = UIImage(named: "Vector")
            static let leftImageSelected = UIImage(named: "vector_editing")
            static let rightImageNormal = UIImage(named: "list-ui-alt")
            static let rightImageSelected = UIImage(named: "list-ui-alt_selected")
        }

        enum Sort {
            static let unChecked = UIImage(named: "UnChecked")
            static let isChecked = UIImage(named: "isChecked")
        }
    }

    enum Colors {
        static let mainBackground = UIColor.white
        static let violet = UIColor(hex: "#669C8B") ?? .systemGreen
        static let separator = UIColor(hex: "#C3C3C6") ?? .systemGreen
        static let profileBackground = UIColor(hex: "#F7F7F8") ?? .systemGreen
        static let skeleton = UIColor(hex: "#F3F3F6") ?? .systemGreen
        static let networkError = UIColor(hex: "#F44336") ?? .systemGreen

        enum SearchBar {
            static let secondary = UIColor(hex: "#F7F7F8") ?? .systemGreen
            static let placeholder = UIColor(hex: "#C3C3C6") ?? .systemGreen
        }

        enum Text {
            static let active = UIColor(hex: "#050510") ?? .systemGreen
            static let inActive = UIColor(hex: "#97979B") ?? .systemGreen
            static let secondary = UIColor(hex: "#55555C") ?? .systemGreen
        }
    }

    enum Fonts {
        static func interMedium(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .medium)
        }

        static func interRegular(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }

        static func interSemiBold(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }

        static func interBold(with size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }

    enum Strings {

        enum Department: String {
            case all = "allTab.title"
            case android = "androidTab.title"
            case ios = "iosTab.title"
            case design = "designTab.title"
            case management = "managementTab.title"
            case qa = "qaTab.title"
            case backOffice = "backOfficeTab.title"
            case frontend = "frontendTab.title"
            case hr = "hrTab.title"
            case pr = "prTab.title"
            case backend = "backendTab.title"
            case support = "supportTab.title"
            case analytics = "analyticsTab.title"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum SearchBar: String {
            case placeholder = "placeholderSearchBar.title"
            case cancel = "cancelSearchBar.title"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum Sort: String {
            case title = "sort.title"
            case sortByAlphabet = "sortByAlphabet.text"
            case sortByBirthday = "sortByBirthday.text"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum NetworkError: String {
            case networkErrorText = "networkConnectionError.text"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum SearchError: String {
            case title = "searchError.title"
            case message = "searchError.text"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum UnknownError: String {
            case tryAgain = "tryAgain.text"
            case tryAgainSelected = "tryAgainSelected.text"
            case title = "unknownError.title"
            case message = "unknownError.text"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }

        enum Years: String {
            case firstCase = "firstCase.text"
            case secondCase = "secondCase.text"
            case thirdCase = "thirdCase.text"

            var localizedString: String {
                NSLocalizedString(self.rawValue, comment: "")
            }
        }
    }
}
