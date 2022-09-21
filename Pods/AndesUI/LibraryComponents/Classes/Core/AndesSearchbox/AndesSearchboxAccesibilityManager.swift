//
//  AndesSearchboxAccesibilityManager.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 30/05/2022.
//

import Foundation

class AndesSearchboxAccesibilityManager: AndesAccessibilityManager {
    private weak var view: AndesSearchbox!

    required init(view: UIView) {
        guard let searchbox = view as? AndesSearchbox else {
            fatalError("AndesSearchboxAccesibilityManager should recieve an AndesSearchbox")
        }
        self.view = searchbox
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityLabel = view.placeholder
        view.accessibilityValue = view.searchText
    }

    func accessibilityActivated() {
        view.becomeFirstResponder()
    }
}
