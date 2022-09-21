//
//  AndesInputStepperTextDataSource.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

@objc public protocol AndesInputStepperTextDataSource: AnyObject {
    @objc func andesInputStepper(_ inputStepper: AndesInputStepper, textFor value: Int) -> NSAttributedString?
}
