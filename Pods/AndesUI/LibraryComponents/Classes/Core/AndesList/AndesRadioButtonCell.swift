//
//  AndesRadioButtonCell.swift
//  AndesUI
//
//  Created by Alvaro Hernan Orellana Villarroel on 01/08/2022.
//

import Foundation

public class AndesRadioButtonCell: AndesListCell {
    /**
     This method initialize an AndesTimePickerCell to draw the row
     - Parameters:
       - title: Set the title for the cell
       - subtitle: Set the subtitle for the cell
       - thumbnail: Set a thumbnail to the left of the cell
       - numberOfLines: Set the number of lines to the cell title, the default is 0
       - isSelected: Indicates if the radioButton is checked, the default value is false
    */
    @objc public init(withTitle title: String,
                      subtitle: String? = nil,
                      thumbnail: AndesThumbnail? = nil,
                      numberOfLines: Int = 0,
                      isSelected: Bool = false) {
        super.init()
        self.cellConfig(withTitle: title, subtitle: subtitle, thumbnail: thumbnail, numberOfLines: numberOfLines, isSelected: isSelected)
    }

    private func cellConfig(withTitle title: String,
                            subtitle: String?,
                            thumbnail: AndesThumbnail? = nil,
                            numberOfLines: Int,
                            isSelected: Bool) {
        self.type = .radioButton
        self.title = title
        self.subtitle = subtitle ?? ""
        self.numberOfLines = numberOfLines
        self.thumbnail = thumbnail
        self.isSelected = isSelected
    }

    override func updateSize(size: AndesListSize) {
        let config = AndesListCellFactory.provide(withSize: size,
                                                  subTitleIsEmpty: subtitle.isEmpty,
                                                  thumbnail: thumbnail)

        self.fontStyle = config.font
        self.fontSubTitleStyle = config.fontDescription
        self.paddingLeftCell = config.paddingLeft
        self.paddingRightCell = config.paddingRight
        self.paddingTopCell = config.paddingTop
        self.paddingBottomCell = config.paddingBottom
        self.subTitleHeight = config.descriptionHeight
        self.separatorHeight = config.separatorHeight
        self.heightConstraint = config.height
        self.titleHeight = config.titleHeight
        self.chevron = config.chevronImage
        self.chevronSize = config.chevronSize
        self.thumbnailLeft = config.thumbnailLeft
        self.thumbnailSize = config.thumbnailSize
        self.separatorThumbnailWidth = config.separatorThumbnailWidth
        self.paddingTopThumbnail = config.paddingTopThumbnail
        self.paddingBottomThumbnail = config.paddingBottomThumbnail
        self.paddingTopChevron = config.paddingTopChevron
        self.paddingBottomChevron = config.paddingBottomChevron
        self.separatorChevronWidth = config.separatorChevronWidth
        self.paddingRightSelectionItem = config.paddingRightSelectionItem
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
