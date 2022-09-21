//
//  AndesBadgeTypeWarning.swift
//  AndesUI
//

import Foundation

class AndesBadgeTypeWarning: AndesBadgeTypeProtocol {
    var primaryVariantColor: UIColor = UIColor.Andes.orange600
    var primaryColor: UIColor = UIColor.Andes.orange500
    var secondaryColor: UIColor = UIColor.Andes.orange100

    func getIcon(size: AndesBadgeSize) -> String {
        switch size {
        case .large:
            return AndesIcons.feedbackWarning24
        case .small:
            return AndesIcons.feedbackWarning16
        }
    }
}
