//
//  AndesSearchboxStateFocus.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 31/05/2022.
//

import Foundation

internal struct AndesSearchboxStateFocus: AndesSearchboxStateProtocol {
    var borderColor: CGColor = AndesStyleSheetManager.styleSheet.accentColor400.cgColor
    var borderWidth: CGFloat = 3
}
