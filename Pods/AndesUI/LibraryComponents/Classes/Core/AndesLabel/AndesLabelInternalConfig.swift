//
//  AndesLabelInternalConfig.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/03/2022.
//

import Foundation

import Foundation

internal class AndesLabelInternalConfig: NSObject {
    public let size: CGFloat
    public let lineHeight: CGFloat
    let color: UIColor
    let bodyLinks: AndesBodyLinks?
    let bodyBolds: AndesBodyBolds?
    private(set) var fontStyle: AndesFontStyle
    private(set) var fontStyleBold: AndesFontStyle
    let isLinkColorInverted: Bool

    @objc
    public init(size: CGFloat, lineHeight: CGFloat, color: UIColor, bodyLinks: AndesBodyLinks?, bodyBolds: AndesBodyBolds?, isLinkColorInverted: Bool = false) {
        self.size = size
        self.lineHeight = lineHeight
        self.color = color
        self.bodyLinks = bodyLinks
        self.bodyBolds = bodyBolds
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: color,
                                        font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: self.size),
                                        lineSpacing: 0,
                                        fontLineHeight: self.lineHeight)
        self.fontStyleBold = AndesFontStyle(textColor: color,
                                            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: self.size),
                                            lineSpacing: 0,
                                            fontLineHeight: self.lineHeight)
        super.init()
    }

    @objc
    public init(size: CGFloat, lineHeight: CGFloat, andesColor: AndesLabelColor, bodyLinks: AndesBodyLinks?, bodyBolds: AndesBodyBolds?, isLinkColorInverted: Bool = false) {
        self.size = size
        self.lineHeight = lineHeight
        self.color = andesColor.color
        self.bodyLinks = bodyLinks
        self.bodyBolds = bodyBolds
        self.isLinkColorInverted = isLinkColorInverted
        self.fontStyle = AndesFontStyle(textColor: andesColor.color,
                                        font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: self.size),
                                        lineSpacing: 0,
                                        fontLineHeight: self.lineHeight)
        self.fontStyleBold = AndesFontStyle(textColor: color,
                                            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: self.size),
                                            lineSpacing: 0,
                                            fontLineHeight: self.lineHeight)
        super.init()
    }
}
