//
//  AndesBadgeHierarchySecondary.swift
//  AndesUI
//
//  Created by Eden Torres on 25/10/2021.
//

struct AndesBadgeHierarchySecondary: AndesBadgeHierarchyProtocol {
    var backgroundColor: UIColor
    var textColor: UIColor

    init(type: AndesBadgeTypeProtocol) {
        backgroundColor = type.primaryVariantColor
        textColor = AndesStyleSheetManager.styleSheet.textColorWhite
    }
}
