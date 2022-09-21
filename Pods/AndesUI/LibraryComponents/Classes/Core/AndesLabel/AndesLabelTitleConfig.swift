//
//  AndesLabelTitleConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc public class AndesLabelTitleConfig: NSObject {
    let titleSize: AndesLabelTitleSize
    public let color: UIColor
    private(set) var fontStyle: AndesFontStyle
    let bodyLinks: AndesBodyLinks?
    let isLinkColorInverted: Bool

    @objc
    public init(titleSize: AndesLabelTitleSize, color: UIColor, bodyLinks: AndesBodyLinks?, isLinkColorInverted: Bool = false) {
        self.titleSize = titleSize
        self.color = color
        self.bodyLinks = bodyLinks
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: color,
                                        font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: titleSize.size),
                                        lineSpacing: 0,
                                        fontLineHeight: titleSize.lineHeight)
        super.init()
    }

    @objc
    public init(titleSize: AndesLabelTitleSize, andesColor: AndesLabelColor, bodyLinks: AndesBodyLinks?, isLinkColorInverted: Bool = false) {
        self.titleSize = titleSize
        self.color = andesColor.color
        self.bodyLinks = bodyLinks
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: andesColor.color,
                                        font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: titleSize.size),
                                        lineSpacing: 0,
                                        fontLineHeight: titleSize.lineHeight)
        super.init()
    }
}
