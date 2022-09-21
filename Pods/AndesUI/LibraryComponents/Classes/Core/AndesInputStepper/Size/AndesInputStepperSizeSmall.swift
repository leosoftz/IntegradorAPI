//
//  AndesInputStepperSizeSmall.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

internal struct AndesInputStepperSizeSmall: AndesInputStepperSizeProtocol {
    var height: CGFloat = 32
    var borderWidth: CGFloat = 1
    var cornerRadius: CGFloat = 6
    var buttonWidth: CGFloat = 24
    var buttonHeight: CGFloat = 28
    var buttonTopConstraint: CGFloat = 2
    var buttonLateralConstraint: CGFloat = 2
    var iconTopConstraint: CGFloat = 8
    var iconLateralConstraint: CGFloat = 6
    var font: CGFloat = 14
    var progress: AndesProgressIndicatorSize = .xSmall
}
