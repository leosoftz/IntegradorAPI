//
//  AndesFeedbackScreenViewTextBase.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 14/09/21.
//

import Foundation
import UIKit

protocol AndesFeedbackScreenViewTextBase: UIView {
    var titleLabel: UILabel { get }
    var feedbackText: AndesFeedbackScreenText { get }
    var overlineLabel: UILabel { get }
    var highlightedLabel: UILabel { get }
    var descriptionTextView: UITextView { get }
    var overlineMode: Bool { get }
}

extension AndesFeedbackScreenViewTextBase {
    func setupBaseOverlineLabel(overlineText: String) {
        let fontStyleOverline = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS), lineSpacing: 5, fontLineHeight: 18)
        overlineLabel.translatesAutoresizingMaskIntoConstraints = false
        overlineLabel.text = overlineText
        overlineLabel.setAndesStyle(style: fontStyleOverline, lineHeight: 18)
        overlineLabel.backgroundColor = UIColor.clear
        overlineLabel.numberOfLines = 0
        overlineLabel.textColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        overlineLabel.lineBreakMode = .byWordWrapping
    }

    func setupBaseDescriptiontext(descriptionText: String, fontStyleDescription: AndesFontStyle) {
        descriptionTextView.isScrollEnabled = false
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = true
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.backgroundColor = UIColor.clear
        descriptionTextView.attributedText = self.getAttributedTextWithLinks(text: descriptionText, bodyLinks: self.feedbackText.descriptionLinks, fontStyle: fontStyleDescription)
        descriptionTextView.textContainer.lineBreakMode = .byWordWrapping
    }

    func setupBaseHighlightedLabel(_ fontStyleHighlighted: AndesFontStyle) {
        highlightedLabel.backgroundColor = UIColor.clear
        highlightedLabel.translatesAutoresizingMaskIntoConstraints = false
        highlightedLabel.text = self.feedbackText.highlighted
        highlightedLabel.setAndesStyle(style: fontStyleHighlighted, lineHeight: 20)
        highlightedLabel.numberOfLines = 0
        highlightedLabel.lineBreakMode = .byWordWrapping
    }

    func setupBaseTitleLabel() {
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = self.feedbackText.title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }

    func getAttributedTextWithLinks(text: String, bodyLinks: AndesBodyLinks?, fontStyle: AndesFontStyle) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let allRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: fontStyle.textColor, range: allRange)
        attributedString.addAttribute(.font, value: fontStyle.font, range: allRange)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = fontStyle.fontLineHeight
        paragraphStyle.maximumLineHeight = fontStyle.fontLineHeight
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)
        if let bodyLinks = bodyLinks {
            for (index, link) in bodyLinks.links.enumerated() {
                if link.isValidRange(attributedString) {
                    let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
                    attributedString.addAttribute(.link, value: String(describing: index), range: range)
                }
            }
        }
        return attributedString
    }
}
