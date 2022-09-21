//
//  AndesFloatingMenuConfigBuilder.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 22/06/2021.
//

import Foundation
import UIKit

@objc public class AndesFloatingMenuConfigBuilder: NSObject {
    @objc public var fromFrame: CGRect
    @objc public var searchbox: AndesSearchbox?
    @objc public var andesList: AndesList
    @objc public var parentView: UIView
    @objc public var widthType: AndesFloatingMenuWidthType
    @objc public var showFrom: AndesFloatingOpenTypeHorizontal = .left
    @objc public var rowsDisplayed: AndesFloatingMenuNumberRow = .medium
    @objc public var heigthNavBar: CGFloat
    @objc public var fixedWidth: CGFloat = 150
    @objc public var isForTimePicker: Bool = false

    @objc public init(andesList: AndesList, parentView: UIView) {
        self.fromFrame = CGRect.zero
        self.andesList = andesList
        self.parentView = parentView
        self.widthType = .fixed
        self.heigthNavBar = 96.0
        self.showFrom = .left
        super.init()
    }

    @objc public func buildConfig() -> AndesFloatingMenuConfig {
        return AndesFloatingMenuConfig(fromFrame: fromFrame,
                                       searchbox: searchbox,
                                       andesList: andesList,
                                       parentView: parentView,
                                       widthType: widthType,
                                       showFrom: showFrom,
                                       rowsDisplayed: rowsDisplayed,
                                       heigthNavBar: heigthNavBar,
                                       fixedWidth: fixedWidth)
    }
}
