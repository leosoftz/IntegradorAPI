//
//  AndesInputStepperSizeProtocol.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

/**
 The AndesInputStepperSizeProtocol provides the differents attributes that define the size of the Indicator, these can be constants or calculated
 */
internal protocol AndesInputStepperSizeProtocol {
    var height: CGFloat { get }
    var borderWidth: CGFloat { get }
    var cornerRadius: CGFloat { get }
    var buttonWidth: CGFloat { get }
    var buttonHeight: CGFloat { get }
    var buttonTopConstraint: CGFloat { get }
    var buttonLateralConstraint: CGFloat { get }
    var iconTopConstraint: CGFloat { get }
    var iconLateralConstraint: CGFloat { get }
    var font: CGFloat { get }
    var progress: AndesProgressIndicatorSize { get }
}
