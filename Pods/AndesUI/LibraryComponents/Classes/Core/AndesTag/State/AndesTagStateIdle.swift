//
//  AndesTagStateIdle.swift
//  AndesUI
//
//  Created by Facundo Conil on 9/28/20.
//

import Foundation

struct AndesTagStateIdle: AndesTagStateProtocol {
    var textColor: UIColor = AndesStyleSheetManager.styleSheet.textColorPrimary

    var borderColor: UIColor = UIColor.Andes.gray250

    var buttonColor: UIColor = UIColor.Andes.gray900

    var backgroundColor: UIColor = UIColor.clear

    var rightButtonImageName: String?
}
