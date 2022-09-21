//
//  AndesInputStepperSizeLarge.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

internal struct AndesInputStepperSizeLarge: AndesInputStepperSizeProtocol {
    var height: CGFloat = 48
    var borderWidth: CGFloat = 1
    var cornerRadius: CGFloat = 6
    var buttonWidth: CGFloat = 32
    var buttonHeight: CGFloat = 40
    var buttonTopConstraint: CGFloat = 4
    var buttonLateralConstraint: CGFloat = 4
    var iconTopConstraint: CGFloat = 12
    var iconLateralConstraint: CGFloat = 8
    var font: CGFloat = 16
    var progress: AndesProgressIndicatorSize = .small
}
