//
//  AndesLabelBodyConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 26/10/2021.
//

import Foundation

@objc public class AndesLabelBodyConfig: NSObject {
    let bodySize: AndesLabelBodySize
    public let color: UIColor
    let bodyLinks: AndesBodyLinks?
    let bodyBolds: AndesBodyBolds?
    private(set) var fontStyle: AndesFontStyle
    private(set) var fontStyleBold: AndesFontStyle
    let isLinkColorInverted: Bool

    @objc
    public init(bodySize: AndesLabelBodySize, color: UIColor, bodyLinks: AndesBodyLinks?, bodyBolds: AndesBodyBolds?, isLinkColorInverted: Bool = false) {
        self.bodySize = bodySize
        self.color = color
        self.bodyLinks = bodyLinks
        self.bodyBolds = bodyBolds
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: color,
                                        font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: bodySize.size),
                                        lineSpacing: 0,
                                        fontLineHeight: bodySize.lineHeight)
        self.fontStyleBold = AndesFontStyle(textColor: color,
                                            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: bodySize.size),
                                            lineSpacing: 0,
                                            fontLineHeight: bodySize.lineHeight)
        super.init()
    }

    @objc
    public init(bodySize: AndesLabelBodySize, andesColor: AndesLabelColor, bodyLinks: AndesBodyLinks?, bodyBolds: AndesBodyBolds?, isLinkColorInverted: Bool = false) {
        self.bodySize = bodySize
        self.color = andesColor.color
        self.bodyLinks = bodyLinks
        self.bodyBolds = bodyBolds
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: andesColor.color,
                                        font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: bodySize.size),
                                        lineSpacing: 0,
                                        fontLineHeight: bodySize.lineHeight)
        self.fontStyleBold = AndesFontStyle(textColor: color,
                                            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: bodySize.size),
                                            lineSpacing: 0,
                                            fontLineHeight: bodySize.lineHeight)
        super.init()
    }
}
