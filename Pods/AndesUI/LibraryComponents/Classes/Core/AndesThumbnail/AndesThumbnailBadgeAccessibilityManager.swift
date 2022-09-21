//
//  AndesThumbnailBadgeAccessibilityManager.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 6/09/22.
//

import Foundation

class AndesThumbnailBadgeAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesThumbnailBadge!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesThumbnailBadge else {
            fatalError("AndesThumbnailBadgeAccessibilityManager should recieve an AndesThumbnailBadge")
        }
        self.view = accessibleView
    }

    func viewUpdated() {

        guard let accessibilityDescription = view.accessibilityDescription else {
            return
        }

        view.isAccessibilityElement = accessibilityDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? false : true

        if let badge = (view.contentView as? AndesThumbnailBadgeableView),
           let badgePill = (badge.badgeView as? AndesBadgePill) {

            let badgePillAccessibilityLabel = (badgePill.contentView as? AndesBadgeViewPill)?.textLabel.text

            view.accessibilityLabel = view.isAccessibilityElement ? "\(accessibilityDescription) \(badgePillAccessibilityLabel ?? "")" : nil
        } else {
            view.accessibilityLabel = accessibilityDescription
        }
    }

    func accessibilityActivated() {
        // Not needed
    }
}
