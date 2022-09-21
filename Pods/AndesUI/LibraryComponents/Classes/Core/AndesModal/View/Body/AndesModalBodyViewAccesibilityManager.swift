//
//  AndesModalBodyViewAccesibilityManager.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 8/06/22.
//

import Foundation

class AndesModalBodyViewAccesibilityManager: AndesAccessibilityManager {
    private weak var view: AndesModalBodyView!

    required init(view: UIView) {
        guard let view = view as? AndesModalBodyView else {
            fatalError("\(self) should recieve an UIButton")
        }
        self.view = view
        self.viewUpdated()
    }

    func viewUpdated() {
        var elements: [UIView] = []
        if view.config.options.allowsCloseButton {
            if view.config.options.isFixedTitleEnabled {
                elements.append(view.fixedCloseButton)
            } else {
                elements.append(view.config.options.imageStyle == .none ? view.closeButton : view.fixedCloseButton)
            }
        }

        if let label = view.source?.image?.accessibilityLabel {
            view.imageContainer.imageView.isAccessibilityElement = true
            view.imageContainer.imageView.accessibilityLabel = label
            elements.append(view.imageContainer.imageView)
        } else {
            view.imageContainer.imageView.accessibilityLabel = nil
            view.imageContainer.imageView.isAccessibilityElement = true
        }

        elements.append(view.titleView.titleLabel)
        elements.append(view.bodyLabel)

        if let footer = view.config.footerView {
            elements.append(contentsOf: footer.buttonList)
        }

        view.fixedTitleView.titleLabel.isAccessibilityElement = false
        view.isAccessibilityElement = false
        /// en modal full cuando hay mucho contenido y es necesarion hacer scroll, voiceover se confunde con el titulo fijo
        view.accessibilityElements = elements

        view.titleView.accessibilityTraits = [.staticText, .header]
        view.bodyLabel.accessibilityTraits = [.staticText]
    }

    func accessibilityActivated() {
    }
}
