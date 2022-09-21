//
//  AndesInputStepperViewDelegate.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/07/22.
//

import Foundation

protocol AndesInputStepperViewDelegate: AnyObject {
    func andesInputStepperView(_ inputStepper: AndesInputStepperView, didSelect value: Int, state: AndesInputStepperState, sender: AndesInputStepperSender)
}
