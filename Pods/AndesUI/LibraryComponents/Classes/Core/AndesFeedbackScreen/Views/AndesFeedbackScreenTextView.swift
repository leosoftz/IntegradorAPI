//
//  AndesFeedbackScreenTextView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/08/2021.
//

import UIKit

class AndesFeedbackScreenTextView: UIView, AndesFeedbackScreenViewTextBase {
    let feedbackText: AndesFeedbackScreenText
    private let addBottomMargin: Bool
    private let feedbackColor: AndesFeedbackScreenColor
    private let separatorView16 = ViewUtils.buildSeparatorView(toSize: 16, color: .clear)
    let titleLabel = UILabel(forAutoLayout: ())
    let overlineLabel = UILabel(forAutoLayout: ())
    let highlightedLabel = UILabel(forAutoLayout: ())
    let descriptionTextView = UITextView(forAutoLayout: ())

    private let innerMargin: CGFloat = 16
    private let margin: CGFloat = 20
    private let cardTextWidth: CGFloat

    var overlineMode: Bool {
        return self.feedbackText.overline != nil
    }

    private var highlightedCase: Bool {
        return self.feedbackText.highlighted != nil && !overlineMode
    }

    init(screenData: AndesFeedbackScreenText, feedbackColor: AndesFeedbackScreenColor, addBottomMargin: Bool) {
        self.addBottomMargin = addBottomMargin
        self.feedbackText = screenData
        self.feedbackColor = feedbackColor
        self.cardTextWidth = UIScreen.main.bounds.width - (margin * 2) - (innerMargin * 2)
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.buildSubview()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildSubview() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.autoSetDimension(.width, toSize: cardTextWidth)
        if let overlineText = self.feedbackText.overline {
            stackView.addArrangedSubview(setupOverlineLabel(overlineText: overlineText))
            let separatorView8 = ViewUtils.buildSeparatorView(toSize: 8, color: .clear)
            stackView.addArrangedSubview(separatorView8)
        }

        stackView.addArrangedSubview(setupTitleLabel())
        if highlightedCase {
            let separatorView8 = ViewUtils.buildSeparatorView(toSize: 8, color: .clear)
            stackView.addArrangedSubview(separatorView8)
            stackView.addArrangedSubview(self.setupHighlightedLabel())
        }
        if let descriptionText = self.feedbackText.descriptionText, descriptionText != "" && !overlineMode {
            let separatorView8 = ViewUtils.buildSeparatorView(toSize: 8, color: .clear)
            stackView.addArrangedSubview(separatorView8)
            stackView.addArrangedSubview(descriptionTextView(descriptionText: descriptionText))
        }
        if self.addBottomMargin {
            stackView.addArrangedSubview(self.separatorView16)
        }

        if let errorCode = self.feedbackText.errorCodeText {
            let errorCodeView = AndesFeedbackScreenErrorCodeView(errorCode: errorCode)
            let separatorView8 = ViewUtils.buildSeparatorView(toSize: 8, color: .clear)
            stackView.addArrangedSubview(separatorView8)
            stackView.addArrangedSubview(errorCodeView)
        }

        self.addSubview(stackView)
        stackView.autoPinEdge(toSuperviewEdge: .top)
        stackView.autoPinEdge(toSuperviewEdge: .bottom)
        stackView.autoPinEdge(toSuperviewEdge: .leading)
        stackView.autoPinEdge(toSuperviewEdge: .trailing)
    }

    private func setupTitleLabel() -> UILabel {
        let fontStyleTitle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.titleM), lineSpacing: 5, fontLineHeight: 22)
        setupBaseTitleLabel()
        titleLabel.setAndesStyle(style: fontStyleTitle, lineHeight: 30)
        titleLabel.textAlignment = .center
        titleLabel.preferredMaxLayoutWidth = cardTextWidth
        titleLabel.autoSetDimension(.height, toSize: titleLabel.sizeToFitHeightCGFloat())
        return titleLabel
    }

    private func setupOverlineLabel(overlineText: String) -> UILabel {
        setupBaseOverlineLabel(overlineText: overlineText)
        overlineLabel.textAlignment = .center
        overlineLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - margin * 2 - (innerMargin * 2)
        return overlineLabel
    }

    private func setupHighlightedLabel() -> UILabel {
        let fontStyleHighlighted = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyM), lineSpacing: 5, fontLineHeight: 22)
        setupBaseHighlightedLabel(fontStyleHighlighted)

        highlightedLabel.textAlignment = .center
        highlightedLabel.preferredMaxLayoutWidth = self.cardTextWidth
        highlightedLabel.textColor = self.feedbackUIColor()
        highlightedLabel.autoSetDimension(.height, toSize: highlightedLabel.sizeToFitHeightCGFloat())
        return highlightedLabel
    }

    private func descriptionTextView(descriptionText: String) -> UITextView {
        let fontStyleDescription = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary, font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyM), lineSpacing: 5, fontLineHeight: 20)

        setupBaseDescriptiontext(descriptionText: descriptionText, fontStyleDescription: fontStyleDescription)
        descriptionTextView.textAlignment = .center
        let sizeThatFitsTextView = descriptionTextView.sizeThatFits(CGSize(width: cardTextWidth, height: CGFloat(MAXFLOAT)))
        descriptionTextView.autoSetDimension(.height, toSize: sizeThatFitsTextView.height)
        descriptionTextView.delegate = self
        return descriptionTextView
    }

    private func feedbackUIColor() -> UIColor {
        switch self.feedbackColor {
        case .green:
            return AndesStyleSheetManager.styleSheet.feedbackColorPositive
        case .red:
            return AndesStyleSheetManager.styleSheet.feedbackColorNegative
        case .orange:
            return AndesStyleSheetManager.styleSheet.feedbackColorCaution
        case .gray:
            return AndesStyleSheetManager.styleSheet.textColorDisabled
        }
    }
}

extension AndesFeedbackScreenTextView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let index = Int(String(describing: URL)) ?? 0
        self.feedbackText.descriptionLinks?.listener(index)
        return false
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        false
    }
}
