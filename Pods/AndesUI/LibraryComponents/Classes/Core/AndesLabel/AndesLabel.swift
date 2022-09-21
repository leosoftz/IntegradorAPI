//
//  AndesLabel.swift
//  testapp
//
//  Created by JULIAN BRUNO on 06/10/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

public class AndesLabel: UILabel, AndesAccessibleView {
    private(set) var bodyBolds: AndesBodyBolds?
    private(set) var bodyLinks: AndesBodyLinks?
    private var type: AndesLabelType = .body
    private var isLinkColorInverted: Bool = false
    private var boldAndesFontStyle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary,
                                                    font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyM),
                                                    lineSpacing: 5,
                                                    fontLineHeight: AndesFontSizeLineHeight.bodyM)

    private var normalAndesFontStyle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary,
                                                      font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS),
                                              lineSpacing: 5,
                                              fontLineHeight: AndesFontSizeLineHeight.bodyM)
    var accessibilityManager: AndesAccessibilityManager?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGesture()
        self.setupBaseFont()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupGesture()
        self.setupBaseFont()
    }

    private func setupBaseFont() {
        self.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS)
    }

    @objc
    public func setStyleAsTitle(titleConfig: AndesLabelTitleConfig) {
        self.type = .title
        self.bodyLinks = titleConfig.bodyLinks
        self.bodyBolds = nil
        self.normalAndesFontStyle = titleConfig.fontStyle
        self.isLinkColorInverted = titleConfig.isLinkColorInverted
        self.setup()
    }

    @objc
    public func setStyleAsBody(bodyConfig: AndesLabelBodyConfig) {
        self.type = .body
        self.bodyLinks = bodyConfig.bodyLinks
        self.bodyBolds = bodyConfig.bodyBolds
        self.normalAndesFontStyle = bodyConfig.fontStyle
        self.boldAndesFontStyle = bodyConfig.fontStyleBold
        self.isLinkColorInverted = bodyConfig.isLinkColorInverted
        self.setup()
    }

    internal func setStyleAsInternal(internalConfig: AndesLabelInternalConfig) {
        self.type = .body // body with custom sizes
        self.bodyLinks = internalConfig.bodyLinks
        self.bodyBolds = internalConfig.bodyBolds
        self.normalAndesFontStyle = internalConfig.fontStyle
        self.boldAndesFontStyle = internalConfig.fontStyleBold
        self.isLinkColorInverted = internalConfig.isLinkColorInverted
        self.setup()
    }

    private func setup() {
        if let text = self.text {
            self.numberOfLines = self.numberOfLines
            self.attributedText = self.getAttributedTextWithLinks(text: text)
            self.sizeToFit()
            if let manager = self.accessibilityManager as? AndesLabelAccessibilityManager {
                manager.clearA11yText()
                manager.addToA11y(text: text)
                manager.viewUpdated()
            }
        }
    }

    private func setupGesture() {
        self.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapgesture)
        accessibilityManager = AndesLabelAccessibilityManager(view: self)
    }

    private func getAttributedTextWithLinks(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let allRange = NSRange(location: 0, length: attributedString.length)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.maximumLineHeight = normalAndesFontStyle.fontLineHeight
        paragraphStyle.minimumLineHeight = normalAndesFontStyle.fontLineHeight

        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)
        attributedString.addAttributes(
            setCustomAttributes(
                textColor: self.isLinkColorInverted ?
                AndesStyleSheetManager.styleSheet.bgColorWhite : normalAndesFontStyle.textColor,
                font: normalAndesFontStyle.font,
                isLink: false),
            range: allRange)

        if let bodyBolds = self.bodyBolds {
            for bold in bodyBolds.bolds {
                if bold.isValidRange(attributedString) {
                    let range = NSRange(location: bold.startIndex, length: bold.endIndex - bold.startIndex)
                    attributedString.addAttributes(
                        setCustomAttributes(
                            textColor: self.isLinkColorInverted ?
                            AndesStyleSheetManager.styleSheet.bgColorWhite : boldAndesFontStyle.textColor,
                            font: self.boldAndesFontStyle.font,
                            isLink: false),
                        range: range)
                }
            }
        }

        if let bodyLinks = self.bodyLinks {
            for link in bodyLinks.links {
                if link.isValidRange(attributedString) {
                    let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
                        attributedString.addAttributes(
                            setCustomAttributes(
                                textColor: self.isLinkColorInverted ?
                                AndesStyleSheetManager.styleSheet.bgColorWhite : AndesStyleSheetManager.styleSheet.textColorLink,
                                font: (self.isLinkColorInverted && self.type == .body) ?
                                self.boldAndesFontStyle.font : self.normalAndesFontStyle.font,
                                isLink: true),
                            range: range)
                }
            }
        }
       return attributedString
    }

    private func setCustomAttributes(textColor: UIColor, font: UIFont, isLink: Bool) -> [NSAttributedString.Key: Any] {
        var customAttributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: textColor
        ]
        if isLink {
            customAttributes[.underlineColor] = textColor
            customAttributes[.underlineStyle] = self.isLinkColorInverted ? NSUnderlineStyle.single.rawValue : .zero
        }
        return customAttributes
    }

    @objc internal func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let _ = self.text, let links = self.bodyLinks?.links  else { return }
        let linksCount = links.count
        if linksCount > 0 {
            for index in 0...linksCount - 1 {
                let link = links[index]
                let start = link.startIndex
                let length = link.endIndex - link.startIndex
                let range = NSRange(location: start, length: length)
                if gesture.didTapAttributedTextInLabel(label: self, inRange: range) {
                    self.bodyLinks?.listener(index)
                }
            }
        }
    }

    override public func accessibilityActivate() -> Bool {
        accessibilityManager?.accessibilityActivated()
        return accessibilityManager != nil
    }
    @objc
    public func clear() {
        self.attributedText = NSAttributedString(string: "")
        if let manager = self.accessibilityManager as? AndesLabelAccessibilityManager {
            manager.clearA11yText()
        }
    }
    @objc
    public func append(text: String, andesColor: AndesLabelColor) {
        self.append(text: text, color: andesColor.color)
    }
    @objc
    public func append(text: String, color: UIColor? = nil) {
        let combination = NSMutableAttributedString(  )
        if let attributedText = self.attributedText {
            combination.append(attributedText)
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineSpacing = normalAndesFontStyle.fontLineHeight / normalAndesFontStyle.font.pointSize
        let newAttributedString = NSMutableAttributedString(string: text)
        let allRange = NSRange(location: 0, length: newAttributedString.length)
        newAttributedString.removeAttribute(.foregroundColor, range: allRange)
        if let colorToApply = color {
            newAttributedString.addAttribute(.foregroundColor, value: colorToApply, range: allRange)
        } else {
           newAttributedString.addAttribute(.foregroundColor, value: normalAndesFontStyle.textColor, range: allRange)
        }
        newAttributedString.addAttribute(.font, value: normalAndesFontStyle.font, range: allRange)
        newAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)
        combination.append(newAttributedString)

        if let manager = self.accessibilityManager as? AndesLabelAccessibilityManager {
            manager.addToA11y(text: text)
        }
        self.attributedText = combination
    }
    @objc
    public func append(moneyAmount: AndesMoneyAmount, andesColor: AndesLabelColor) {
        self.append(moneyAmount: moneyAmount, color: andesColor.color)
    }

    @objc
    public func append(moneyAmount: AndesMoneyAmount, color: UIColor? = nil) {
        let combination = NSMutableAttributedString(  )
        if let attributedText = self.attributedText {
            combination.append(attributedText)
        }
        let newAttributedString = NSMutableAttributedString(attributedString: moneyAmount.moneyInfo().attributedMoney)
        let allRange = NSRange(location: 0, length: newAttributedString.length)
        newAttributedString.removeAttribute(.foregroundColor, range: allRange)
        if let colorToApply = color {
            newAttributedString.addAttribute(.foregroundColor, value: colorToApply, range: allRange)
        } else {
           newAttributedString.addAttribute(.foregroundColor, value: normalAndesFontStyle.textColor, range: allRange)
        }
        combination.append(newAttributedString)

        if let manager = self.accessibilityManager as? AndesLabelAccessibilityManager {
            manager.addToA11y(text: moneyAmount.moneyInfo().a11yText)
        }
        self.attributedText = combination
    }
    @objc
    public func updateColor(text: String, andesColor: AndesLabelColor) {
        self.updateColor(text: text, color: andesColor.color)
    }
    @objc
    public func updateColor(text: String, color: UIColor) {
        let attrStr: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString(string: ""))
        let range: NSRange = attrStr.mutableString.range(of: text, options: .caseInsensitive)
        attrStr.removeAttribute(.foregroundColor, range: range)
        attrStr.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attrStr
    }
    @objc
    public func updateColor(range: NSRange, andesColor: AndesLabelColor) {
        self.updateColor(range: range, color: andesColor.color)
    }

    @objc
    public func updateColor(range: NSRange, color: UIColor) {
        let attrStr: NSMutableAttributedString = NSMutableAttributedString(attributedString: self.attributedText ?? NSAttributedString(string: ""))
        attrStr.removeAttribute(.foregroundColor, range: range)
        attrStr.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attrStr
    }
}
