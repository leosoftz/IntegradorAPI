//
//  AndesThumbnailBadgeFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 23/08/21.
//

import Foundation

class AndesThumbnailBadgeFactory {
    static func provide(for thumbnail: AndesThumbnailBadge) -> UIView {
        switch (thumbnail.badgeType, thumbnail.size) {
        case (_, .size24), (_, .size32):
            return AndesBadgeDot(type: thumbnail.badgeColor.andesBadgeType())
        case (.icon, .size40), (.icon, .size48), (.icon, .size56):
            return AndesBadgeIcon(iconType: thumbnail.badgeColor, hierarchy: thumbnail.hierarchy,
                                  size: .small)
        case (.icon, .size64), (.icon, .size72), (.icon, .size80):
            return AndesBadgeIcon(iconType: thumbnail.badgeColor, hierarchy: thumbnail.hierarchy,
                                  size: .large)
        case (.pill, .size40), (.pill, .size48), (.pill, .size56):
            return AndesBadgePill(hierarchy: .loud,
                                  type: thumbnail.badgeColor.andesBadgeType(),
                                  border: .standard,
                                  size: .small,
                                  text: thumbnail.badgeText)
        case (.pill, .size64), (.pill, .size72), (.pill, .size80):
            return AndesBadgePill(hierarchy: .loud,
                                  type: thumbnail.badgeColor.andesBadgeType(),
                                  border: .standard,
                                  size: .large,
                                  text: thumbnail.badgeText)
        case (.hidden, _):
            let hiddenBadge = AndesBadgePill()
            hiddenBadge.isHidden = true
            return hiddenBadge
        default:
            return AndesBadgeIcon(iconType: thumbnail.badgeColor, hierarchy: thumbnail.hierarchy,
                                  size: .small)
        }
    }
}
