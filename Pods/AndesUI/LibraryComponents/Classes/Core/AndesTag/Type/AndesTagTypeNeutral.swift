//
//  AndesTagTypeNeutral.swift
//  AndesUI
//
//  Created by Samuel Sainz on 5/28/20.
//

import Foundation

struct AndesTagTypeNeutral: AndesTagTypeProtocol {
    var textColor: UIColor = AndesStyleSheetManager.styleSheet.textColorPrimary

    var borderColor: UIColor = UIColor.Andes.gray250

    var buttonColor: UIColor = UIColor.Andes.gray550

    var backgroundColor: UIColor = UIColor.clear
}
