//
//  AndesMessageAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 17/09/21.
//

import Foundation

class AndesMessageAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesMessage!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesMessage else {
            fatalError("AndesMessageAccessibilityManager should recieve an AndesMessage")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        let titleTraits = view.accessibilityTitleIsHeader ? UIAccessibilityTraits.header : []
        (view.contentView as? AndesMessageAbstractView)?.titleLabel.isAccessibilityElement = true
        (view.contentView as? AndesMessageAbstractView)?.titleLabel.accessibilityLabel = view.title
        (view.contentView as? AndesMessageAbstractView)?.titleLabel.accessibilityTraits = titleTraits
        (view.contentView as? AndesMessageAbstractView)?.dismissButton.accessibilityLabel = "Cerrar mensaje".localized()
    }

    func accessibilityActivated() {
        // Not needed
    }
}
