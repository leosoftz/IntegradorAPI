//
//  AndesBadgeTypeError.swift
//  AndesUI
//

import Foundation

class AndesBadgeTypeError: AndesBadgeTypeProtocol {
    var primaryVariantColor: UIColor = UIColor.Andes.red600
    var primaryColor: UIColor = UIColor.Andes.red500
    var secondaryColor: UIColor = UIColor.Andes.red100

    func getIcon(size: AndesBadgeSize) -> String {
        switch size {
        case .large:
            return AndesIcons.feedbackError24
        case .small:
            return AndesIcons.feedbackError16
        }
    }
}
