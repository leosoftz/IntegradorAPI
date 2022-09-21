//
//  UILabel+Additions.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 3/9/20.
//

import UIKit
@objc public extension UILabel {
    var fontSpacing: CGFloat {
        get {
            guard let font = font else {
                return 0
            }
            return (font.lineHeight - font.pointSize) / 2
        }
    }

    func setAndesStyle(style: AndesFontStyle) {
        self.textColor = style.textColor
        self.font = style.font
        // set text with line height
        let attributedString = NSMutableAttributedString(string: text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = style.lineSpacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }
    func setAndesStyle(style: AndesFontStyle, lineHeight: CGFloat) {
        self.textColor = style.textColor
        self.font = style.font
        let attributedString = NSMutableAttributedString(string: text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeight / self.font.lineHeight
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        self.attributedText = attributedString
    }

    func sizeToFitHeight() {
        let size: CGSize = self.sizeThatFits(CGSize.init(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude))
        var frame: CGRect = self.frame
        frame.size.height = size.height
        self.frame = frame
    }

    func sizeToFitHeightCGFloat() -> CGFloat {
        let size = self.sizeThatFits(CGSize.init(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude)).height
        return size
    }
}
