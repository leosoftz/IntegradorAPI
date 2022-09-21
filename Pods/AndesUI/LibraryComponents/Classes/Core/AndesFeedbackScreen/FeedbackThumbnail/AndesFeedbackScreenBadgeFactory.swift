//
//  AndesFeedbackScreenBadgeFactory.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 1/09/21.
//

import Foundation

class AndesFeedbackScreenBadgeFactory {
    static func createThumbnailBadgeView(thumbnailInfo: AndesFeedbackScreenThumbnail?) -> AndesThumbnailBadge {
        guard let thumbnailInfo = thumbnailInfo,
              let feedbackColor = thumbnailInfo.color else {
            return AndesThumbnailBadge()
        }
        switch thumbnailInfo.thumbnailType {
        case .image:
            let thumbnailBadge = AndesThumbnailBadge(thumbnailType: .imageCircle,
                                                     image: thumbnailInfo.image ?? UIImage(),
                                                     color: feedbackColor.colorType,
                                                     hierarchy: .loud)
            thumbnailBadge.setupBadgeIconPill(color: feedbackColor.colorType,
                                              thumbnailSize: .size64)
            return thumbnailBadge
        case .icon:
            let thumbnailBadge = AndesThumbnailBadge(thumbnailType: .icon,
                                                     image: thumbnailInfo.image ?? UIImage(),
                                                     color: feedbackColor.colorType,
                                                     hierarchy: .loud)
            thumbnailBadge.thumbnailType = .icon
            thumbnailBadge.setupBadgeIconPill(color: feedbackColor.colorType,
                                              thumbnailSize: .size64)
            return thumbnailBadge
        case .iconWithoutBadge:
            let iconImageView = UIImageView()
            AndesIconsProvider.loadIcon(name: feedbackColor.iconName, placeItInto: iconImageView)
            let thumbnailBadge = AndesThumbnailBadge(thumbnailType: .icon,
                                                     image: iconImageView.image ?? UIImage(),
                                                     color: feedbackColor.colorType,
                                                     size: .size64,
                                                     hierarchy: .loud)
            return thumbnailBadge
        }
    }
}
