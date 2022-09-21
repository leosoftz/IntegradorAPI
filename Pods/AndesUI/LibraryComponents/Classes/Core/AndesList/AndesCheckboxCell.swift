//
//  AndesCheckboxCell.swift
//  AndesUI
//
//  Created by Nicolas Martinez on 26/07/2022.
//

import Foundation
/**
 This class is a custom cell to AndesUI, this cell has a basic configuration and a checkbox to the rigth
*/
public class AndesCheckboxCell: AndesListCell {
    /**
     This method initializes an AndesCheckboxCell to draw the row just objc
     - Parameters:
       - title: Set the title for the cell
       - subtitle: Set the subtitle for the cell
       - thumbnail: Set a thumbnail to the left of the cell
       - numberOfLines: Set the number of lines to the cell title, the default is 0
       - isSelected: Indicates if the checkbox is checked, the default value is false
    */
    @objc public init(withTitle title: String,
                      subtitle: String,
                      thumbnail: AndesThumbnail? = nil,
                      numberOfLines: Int,
                      isSelected: Bool = false) {
        super.init()
        self.cellConfig(withTitle: title,
                        subtitle: subtitle,
                        thumbnail: thumbnail,
                        numberOfLines: numberOfLines,
                        isSelected: isSelected)
    }

    private func cellConfig(withTitle title: String,
                            subtitle: String?,
                            thumbnail: AndesThumbnail? = nil,
                            numberOfLines: Int,
                            isSelected: Bool) {
        self.type = .checkBox
        self.title = title
        self.subtitle = subtitle ?? ""
        self.numberOfLines = numberOfLines
        self.thumbnail = thumbnail
        self.isSelected = isSelected
    }

    override func updateSize(size: AndesListSize) {
        let config = AndesListCellFactory.provide(
            withSize: size,
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
        self.thumbnailLeft = config.thumbnailLeft
        self.thumbnailSize = config.thumbnailSize
        self.separatorThumbnailWidth = config.separatorThumbnailWidth
        self.paddingTopThumbnail = config.paddingTopThumbnail
        self.paddingBottomThumbnail = config.paddingBottomThumbnail
        self.paddingRightSelectionItem = config.paddingRightSelectionItem
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
