//
//  AndesInputStepperValueListener.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import Foundation

@objc public protocol AndesInputStepperDelegate: AnyObject {
    @objc func andesInputStepper(_ inputStepper: AndesInputStepper, didSelect value: Int, state: AndesInputStepperState, sender: AndesInputStepperSender)
}
