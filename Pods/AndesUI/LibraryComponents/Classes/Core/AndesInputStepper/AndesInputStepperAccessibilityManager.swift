//
//  AndesInputStepperAccessibilityManager.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 11/07/22.
//

import Foundation

class AndesInputStepperAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesInputStepperView!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesInputStepperView else {
            fatalError("AndesInputStepperAccessibilityManager should recieve an AndesInputStepper")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        guard let inputStepper = view else { return }
        inputStepper.isAccessibilityElement = true
        if view.isLoading {
            inputStepper.accessibilityLabel = "inProgress".localized()
            inputStepper.accessibilityValue = nil
            inputStepper.accessibilityTraits = []
        } else {
            describeCurrentPosition()
            inputStepper.accessibilityLabel = nil
            inputStepper.accessibilityTraits = view.isEnabled ? [.adjustable] : [.notEnabled]
        }
    }

    private func describeCurrentPosition() {
        guard let inputStepper = view else { return }
        if let text = inputStepper.dataSource?.andesInputStepperView(view, textFor: inputStepper.config.value)?.string {
            view.accessibilityValue = "\(text)"
        } else {
            view.accessibilityValue = "\(inputStepper.config.value)"
        }
    }

    func accessibilityActivated() { }

    func accessibilityIncrement() {
        view.nextStep()
        makeAnnouncement(type: .custom(notification: .pageScrolled, argument: describeCurrentPosition()))
    }

    func accessibilityDecrement() {
        view.previousStep()
        makeAnnouncement(type: .custom(notification: .pageScrolled, argument: describeCurrentPosition()))
    }
}
