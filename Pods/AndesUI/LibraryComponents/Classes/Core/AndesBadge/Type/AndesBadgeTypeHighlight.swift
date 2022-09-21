//
//  AndesBadgeTypeHighlight.swift
//  AndesUI
//

import Foundation

class AndesBadgeTypeHighlight: AndesBadgeTypeProtocol {
    var primaryVariantColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor600
    var primaryColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    var secondaryColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor100

    func getIcon(size: AndesBadgeSize) -> String {
        switch size {
        case .large:
            return AndesIcons.feedbackHighlight24
        case .small:
            return AndesIcons.feedbackHighlight16
        }
    }
}
