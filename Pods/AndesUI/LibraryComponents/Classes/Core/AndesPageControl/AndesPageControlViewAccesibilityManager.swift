//
//  AndesPageControlViewAccesibilityManager.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 25/07/22.
//

import Foundation

class AndesPageControlViewAccesibilityManager: AndesAccessibilityManager {
    private weak var view: AndesPageControlView!

    required init(view: UIView) {
        guard let view = view as? AndesPageControlView else {
            fatalError("\(self) should recieve an UIButton")
        }
        self.view = view
        self.viewUpdated()
    }

    private func describeCurrentPosition() -> String {
        "Página %d de %d".localizeWithFormat(arguments: view.selectedPage + 1, view.pages)
    }

    func viewUpdated() {
        /// by default, the pager will not be accessible.
        /// view.isAccessibilityElement = true
        view.accessibilityTraits = [.adjustable]
        view.accessibilityValue = describeCurrentPosition()
    }

    func accessibilityActivated() { }

    func accessibilityIncrement() {
        view.currentPage(view.selectedPage + 1)
        view.delegate?.andesPageControl(view, didPageChangeTo: view.selectedPage)
        makeAnnouncement(type: .custom(notification: .pageScrolled, argument: describeCurrentPosition()))
    }

    func accessibilityDecrement() {
        view.currentPage(view.selectedPage - 1)
        view.delegate?.andesPageControl(view, didPageChangeTo: view.selectedPage)
        makeAnnouncement(type: .custom(notification: .pageScrolled, argument: describeCurrentPosition()))
    }
}
