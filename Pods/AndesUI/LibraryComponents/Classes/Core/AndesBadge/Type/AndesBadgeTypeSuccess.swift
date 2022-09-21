//
//  AndesBadgeTypeSuccess.swift
//  AndesUI
//

import Foundation

class AndesBadgeTypeSuccess: AndesBadgeTypeProtocol {
    var primaryVariantColor: UIColor = UIColor.Andes.green600
    var primaryColor: UIColor = UIColor.Andes.green500
    var secondaryColor: UIColor = UIColor.Andes.green100

    func getIcon(size: AndesBadgeSize) -> String {
        switch size {
        case .large:
            return AndesIcons.feedbackSuccess24
        case .small:
            return AndesIcons.feedbackSuccess16
        }
    }
}
