//
//  AndesSwitchAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 22/06/21.
//

import Foundation

class AndesSwitchAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesSwitch!
    private let onValue = "1"
    private let offValue = "0"

    private var contentView: AndesSwitchAbstractView? {
        view.contentView as? AndesSwitchAbstractView
    }

    private var currentSwitch: UISwitch? {
        view.align == .left ? contentView?.leftSwitch : contentView?.rightSwitch
    }

    required init(view: UIView) {
        guard let andesSwitch = view as? AndesSwitch else {
            fatalError("AndesSwitch AccessibilityManager should recieve an AndesSwitch")
        }
        self.view = andesSwitch
        viewUpdated()
    }

    func viewUpdated() {
        setupAccessibilityLabel()
        setupAccessibilityNavigation()
    }

    func accessibilityActivated() {
        currentSwitch?.setOn(!(currentSwitch?.isOn ?? false), animated: true)
        view.OnStatusChange()
    }

    private func setupAccessibilityLabel() {
        view.accessibilityLabel = view.text
        view.accessibilityTraits = currentSwitch?.accessibilityTraits ?? .none
        view.accessibilityValue = currentSwitch?.isOn ?? false ? onValue : offValue
    }

    private func setupAccessibilityNavigation() {
        view.isAccessibilityElement = true
        contentView?.labelSwitch.isAccessibilityElement = false
        currentSwitch?.isAccessibilityElement = false
    }
}
