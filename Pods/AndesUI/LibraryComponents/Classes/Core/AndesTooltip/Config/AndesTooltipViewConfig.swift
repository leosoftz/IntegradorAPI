//
//
//  AndesTooltipViewConfig.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

/// used to define the ui of internal AndesTooltip views
internal struct AndesTooltipViewConfig {
    let title: String?
    let content: String
    let contentAndesLabel: AndesLabel?
    let isDismissable: Bool

    let textColor: UIColor
    let backgroundColor: UIColor
    let closeButtonColor: UIColor
    let maxWidth: CGFloat

    let titleAlignment: NSTextAlignment
    let contentAlignment: NSTextAlignment

    let shadowColor: UIColor
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: CGFloat

    let primaryActionConfig: AndesButtonViewConfig?
    let secondaryActionConfig: AndesButtonViewConfig?

    let primaryActionOnPressed: (() -> Void)?
    let secondaryActionOnPressed: (() -> Void)?

    let sizeStyle: AndesTooltipWidthSize

    init(type: AndesTooltipTypeProtocol,
         title: String?,
         content: String,
         contentAndesLabel: AndesLabel?,
         isDismissable: Bool,
         primaryActionConfig: AndesButtonViewConfig?,
         secondaryActionConfig: AndesButtonViewConfig?,
         primaryActionOnPressed: (() -> Void)?,
         secondaryActionOnPressed: (() -> Void)?,
         sizeStyle: AndesTooltipWidthSize,
         titleAlignment: NSTextAlignment,
         contentAlignment: NSTextAlignment) {
        backgroundColor = type.backgroundColor
        maxWidth = type.maxWidth
        shadowOffset = type.shadowOffset
        shadowRadius = type.shadowRadius
        shadowOpacity = type.shadowOpacity
        textColor = type.textColor
        closeButtonColor = type.closeButtonColor
        shadowColor = type.shadowColor

        self.title = title
        self.content = content
        self.contentAndesLabel = contentAndesLabel
        self.isDismissable = isDismissable
        self.primaryActionConfig = primaryActionConfig
        self.secondaryActionConfig = secondaryActionConfig
        self.primaryActionOnPressed = primaryActionOnPressed
        self.secondaryActionOnPressed = secondaryActionOnPressed
        self.sizeStyle = sizeStyle
        self.titleAlignment = titleAlignment
        self.contentAlignment = contentAlignment
    }

    func getTitleStyle() -> AndesFontStyle {
        return AndesFontStyle(
            textColor: self.textColor,
            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 16),
            sketchLineHeight: 20
        )
    }

    func getContentStyle() -> AndesFontStyle {
        return AndesFontStyle(
            textColor: self.textColor,
            font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14),
            sketchLineHeight: 18
        )
    }
}
