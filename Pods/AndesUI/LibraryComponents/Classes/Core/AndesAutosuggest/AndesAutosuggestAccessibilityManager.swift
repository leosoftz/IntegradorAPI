//
//  AndesAutosuggestFloatingMenuAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 20/07/22.
//

import Foundation

class AndesAutosuggestAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesAutosuggest!
    required init(view: UIView) {
        guard let accessibleView = view as? AndesAutosuggest else {
            fatalError("AndesAutosuggestAccessibilityManager should recieve an AndesAutosuggest")
        }
        self.view = accessibleView
    }

    func viewUpdated() {
        guard let contentView = (view.contentView as? AndesAutosuggestDefaultView) else {
            return
        }
        contentView.floatingMenu.clearView.isAccessibilityElement = true
        contentView.floatingMenu.clearView.accessibilityLabel = "CloseFloatingMenu".localized()
        contentView.floatingMenu.accessibilityViewIsModal = true
    }

    func accessibilityActivated() {
        // Not needed
    }

    func onAccessibilityPerformEscapeActivated() {
        guard let andesAutosuggestDefaultView = (view.contentView as? AndesAutosuggestDefaultView) else {
            return
        }
        makeAnnouncement(type: .custom(notification: .layoutChanged, argument: andesAutosuggestDefaultView.list, deadline: 1.0))
    }

    func onFloatingMenuOpenAccessibilityActivated() {
        guard let andesAutosuggestDefaultView = (view.contentView as? AndesAutosuggestDefaultView) else {
            return
        }
        let tableView = andesAutosuggestDefaultView.list.tableView
        if tableView.numberOfRows(inSection: 0) > 0 {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
            makeAnnouncement(type: .custom(notification: .layoutChanged, argument: cell))
        }
    }
}
