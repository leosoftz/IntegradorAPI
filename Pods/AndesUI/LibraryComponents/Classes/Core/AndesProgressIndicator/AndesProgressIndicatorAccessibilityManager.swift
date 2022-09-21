//
//  AndesProgressIndicatorAccessibilityManager.swift
//  AndesUI
//
//  Created by Jonathan Andres Castillo Baron on 11/08/22.
//

import Foundation

class AndesProgressIndicatorAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesProgressIndicatorIndeterminate!

    required init(view: UIView) {
        guard let a11yView = view as? AndesProgressIndicatorIndeterminate else { fatalError("is not AndesProgressIndicatorIndeterminate") }
        self.view = a11yView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = (view.accessibilityLabel ?? "").trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? false : true
    }

    func accessibilityActivated() {}
}
