//
//  AndesFloatingMenuConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 21/06/2021.
//

import UIKit

@objc public class AndesFloatingMenuConfig: NSObject {
    @objc let fromFrame: CGRect
    @objc let searchbox: AndesSearchbox?
    @objc let andesList: AndesList
    @objc let parentView: UIView
    @objc let widthType: AndesFloatingMenuWidthType
    @objc let showFrom: AndesFloatingOpenTypeHorizontal
    @objc let rowsDisplayed: AndesFloatingMenuNumberRow
    @objc let heigthNavBar: CGFloat
    @objc let fixedWidth: CGFloat

    init(fromFrame: CGRect,
         searchbox: AndesSearchbox? = nil,
         andesList: AndesList,
         parentView: UIView,
         widthType: AndesFloatingMenuWidthType,
         showFrom: AndesFloatingOpenTypeHorizontal = .left,
         rowsDisplayed: AndesFloatingMenuNumberRow = .medium,
         heigthNavBar: CGFloat,
         fixedWidth: CGFloat = 150) {
        self.fromFrame = fromFrame
        self.searchbox = searchbox
        self.andesList = andesList
        self.parentView = parentView
        self.widthType = widthType
        self.showFrom = showFrom
        self.rowsDisplayed = rowsDisplayed
        self.heigthNavBar = heigthNavBar
        self.fixedWidth = fixedWidth
    }
}
