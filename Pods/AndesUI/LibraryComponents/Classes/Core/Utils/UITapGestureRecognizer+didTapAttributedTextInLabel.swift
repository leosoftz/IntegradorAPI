//
//  UITapGestureRecognizer+didTapAttributedTextInLabel.swift
//  AndesUI
//
//  based in TappableLabel from https://stackoverflow.com/questions/21349725/character-index-at-touch-point-for-uilabel
//

import Foundation

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        /// only detect taps in attributed text
        guard let attributedText = label.attributedText, self.state == .ended else {
            return false
        }
        /// Configure NSTextContainer
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        /// Configure NSLayoutManager and add the text container
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        /// Configure NSTextStorage and apply the layout manager
        let textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addAttribute(NSAttributedString.Key.font, value: label.font!, range: NSRange(location: 0, length: attributedText.length))
        textStorage.addLayoutManager(layoutManager)
        /// get the tapped character location
        let locationOfTouchInLabel = self.location(in: self.view)
        /// account for text alignment and insets
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        var alignmentOffset: CGFloat!
        switch label.textAlignment {
        case .left, .natural, .justified:
            alignmentOffset = 0.0
        case .center:
            alignmentOffset = 0.5
        case .right:
            alignmentOffset = 1.0
        @unknown default:
            alignmentOffset = 0
        }
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        /// figure out which character was tapped
        let characterTapped = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        /// figure out how many characters are in the string up to and including the line tapped
        return NSLocationInRange(characterTapped, targetRange)
    }
}
