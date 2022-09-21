//
//  AndesListCellMediumSize.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 5/11/20.
//

import Foundation

struct AndesListCellMediumSize: AndesListCellSizeProtocol {
    var font = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary,
                              font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyM),
                              lineSpacing: 2,
                              fontLineHeight: 20)
    var fontDescription = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorSecondary,
                              font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS),
                              lineSpacing: 1,
                              fontLineHeight: 18)
    var height: CGFloat = 48
    var paddingLeft: CGFloat = 16
    var paddingRight: CGFloat = 16
    var paddingTop: CGFloat = 14
    var paddingBottom: CGFloat = 14
    var descriptionHeight: CGFloat = 0
    var separatorHeight: CGFloat = 0
    var titleHeight: CGFloat = 11
    var chevronSize: CGFloat? = 16
    var thumbnailSize: CGFloat? = 0
    var separatorThumbnailWidth: CGFloat? = 0
    var paddingTopThumbnail: CGFloat?
    var paddingBottomThumbnail: CGFloat?
    var paddingBottomChevron: CGFloat? = 20
    var paddingTopChevron: CGFloat? = 20
    var separatorChevronWidth: CGFloat? = 12
    var paddingRightSelectionItem: CGFloat? = 16

    init(subTitleIsEmpty: Bool, thumbnail: AndesThumbnail? = nil) {
        if !subTitleIsEmpty {
            height = 68
            paddingBottom = 13
            descriptionHeight = 18
            separatorHeight = 3
        }
        if let thumbnail = thumbnail {
            switch thumbnail.type {
            case .icon:
                thumbnailSize = 20
                separatorThumbnailWidth = 12
                paddingTopThumbnail = 18
            case .imageCircle, .imageSquare:
                height = 68
                thumbnailSize = 40
                separatorThumbnailWidth = 16
                paddingTopThumbnail = subTitleIsEmpty ? 16 : 21
                paddingBottomThumbnail = 14
                paddingTopChevron = subTitleIsEmpty ? 16 : 21
                paddingBottomChevron = 26
            }
        }
    }
}
