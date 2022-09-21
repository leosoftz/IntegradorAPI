//
//  AndesFloatingMenuAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 28/10/21.
//

import Foundation

class AndesFloatingMenuAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesFloatingMenu!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesFloatingMenu else {
            fatalError("AndesFloatingMenuAccessibilityManager should recieve an AndesFloatingMenu")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        self.view.transparentView.isAccessibilityElement = true
        self.view.transparentView.accessibilityLabel = "CloseFloatingMenu".localized()
        self.view.accessibilityViewIsModal = true
    }

    func accessibilityActivated() {
        // Not needed
    }

    func onAccessibilityPerformEscapeActivated() {
        makeAnnouncement(type: .custom(notification: .layoutChanged, argument: self.view.andesList, deadline: 1.0))
    }

    func onFloatingMenuOpenAccessibilityActivated() {
        let tableView = view.andesList.tableView

        if tableView.numberOfRows(inSection: 0) > 0 {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))

            makeAnnouncement(type: .custom(notification: .layoutChanged, argument: cell, deadline: 1.0))
        }
    }
}
