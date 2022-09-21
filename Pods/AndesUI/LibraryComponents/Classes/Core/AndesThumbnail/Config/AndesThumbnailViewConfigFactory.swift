//
//  AndesThumbnailViewConfigFactory.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 26/06/2020.
//

import Foundation

/**
The responsability of the factory is to provide the ViewConfig from the user specified attributes
*/
internal class AndesThumbnailViewConfigFactory {
	static func provide(for thumbnail: AndesThumbnail) -> AndesThumbnailViewConfig {
		let thumbnailType = AndesThumbnailTypeFactory.provide(thumbnail.type, accentColor: thumbnail.accentColor, borderColor: nil)

		let thumbnailHierarchy = AndesThumbnailHierarchyFactory.provide(thumbnail.hierarchy, forType: thumbnailType, status: thumbnail.state)
		let thumbnailSize = AndesThumbnailSizeFactory.provide(thumbnail.size, type: thumbnailType)

        return AndesThumbnailViewConfig(image: thumbnail.image,
                                        size: thumbnailSize.size,
                                        iconSize: thumbnailSize.iconSize,
                                        cornerRadius: thumbnailSize.cornerRadius,
                                        borderColor: thumbnailHierarchy.borderColor,
                                        overlayColor: thumbnailHierarchy.overlayColor,
                                        backgroundColor: thumbnailHierarchy.backgroundColor,
                                        iconColor: thumbnailHierarchy.iconColor,
                                        contentMode: thumbnail.contentMode)
	}

	static func provide(for thumbnailBadge: AndesThumbnailBadge) -> AndesThumbnailViewConfig {
		let outlineColor = AndesBadgeTypeFactory.provide(thumbnailBadge.badgeColor.andesBadgeType()).primaryColor
		let thumbnailType = AndesThumbnailTypeFactory.provide(thumbnailBadge.thumbnailType.thumbnailType(),
															  accentColor: outlineColor,
															  borderColor: nil)
		let thumbnailSize = AndesThumbnailSizeFactory.provide(thumbnailBadge.size, type: thumbnailType)

		let thumbnailBadgeView = AndesThumbnailBadgeFactory.provide(for: thumbnailBadge)

		return AndesThumbnailViewConfig(image: thumbnailBadge.image,
										size: thumbnailSize.size,
										iconSize: thumbnailSize.iconSize,
										cornerRadius: thumbnailSize.cornerRadius,
										borderColor: nil,
										overlayColor: nil,
										backgroundColor: AndesStyleSheetManager.styleSheet.bgColorWhite,
										iconColor: outlineColor,
										outlineColor: outlineColor,
										outlineWidth: thumbnailSize.outlineWidth,
										badgeView: thumbnailBadgeView,
                                        contentMode: thumbnailBadge.contentMode)
	}
}
