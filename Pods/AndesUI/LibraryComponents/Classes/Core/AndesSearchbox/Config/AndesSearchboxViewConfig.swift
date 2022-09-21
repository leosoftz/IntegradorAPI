//
//  AndesSearchboxViewConfig.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 21/05/2022.
//

import Foundation

internal struct AndesSearchboxViewConfig {
    var placeHolder: String = ""
    let tintColor: UIColor = AndesStyleSheetManager.styleSheet.textColorSecondary
    var state: AndesSearchboxStateProtocol = AndesSearchboxStateIdle()
    var cornerRadius: CGFloat = 18
    let clearIconName: String = AndesIcons.close16
    let iconHorizontalOffset: CGFloat = 8
}
