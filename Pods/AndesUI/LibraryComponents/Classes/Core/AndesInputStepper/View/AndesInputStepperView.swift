//
//  AndesInputStepperView.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 20/01/22.
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesInputStepper
 */
internal protocol AndesInputStepperView: UIView {
    var delegate: AndesInputStepperViewDelegate? { get set }
    var dataSource: AndesInputStepperViewTextDataSource? { get set }
    var isLoading: Bool { get set }
    var isEnabled: Bool { get set }
    var config: AndesInputStepperViewConfig { get set }

    func updateInputStepperConstraints()
    func nextStep()
    func previousStep()
}
