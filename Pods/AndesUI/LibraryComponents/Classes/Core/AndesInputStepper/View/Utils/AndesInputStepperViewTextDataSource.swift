//
//  AndesInputStepperViewTextDataSource.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/07/22.
//

import Foundation

protocol AndesInputStepperViewTextDataSource: AnyObject {
    func andesInputStepperView(_ inputStepper: AndesInputStepperView, textFor value: Int) -> NSAttributedString?
}
