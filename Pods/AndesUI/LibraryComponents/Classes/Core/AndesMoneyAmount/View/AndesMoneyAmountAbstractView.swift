//
//  
//  AndesMoneyAmountAbstractView.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//
//

import UIKit

class AndesMoneyAmountAbstractView: UIView, AndesMoneyAmountView {
    private(set) var label: UILabel?
    private(set) var labelSuffix: UILabel?
    private(set) var currencyImage: UIImageView?

    private var labelLeadingConstraint, labelTrailingConstraint: NSLayoutConstraint?

    private var currencyAdditionalOptionalConfig: CurrencyAdditionalOptionalConfig

    private var config: AndesMoneyAmountViewConfig

    func attText() -> NSAttributedString {
        return label?.attributedText ?? NSAttributedString(string: "")
    }

    init(withConfig config: AndesMoneyAmountViewConfig, and currencyAdditionalOptionalConfig: CurrencyAdditionalOptionalConfig) {
        self.config = config
        self.currencyAdditionalOptionalConfig = currencyAdditionalOptionalConfig
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesMoneyAmountViewConfig()
        currencyAdditionalOptionalConfig = CurrencyAdditionalOptionalConfig()
        super.init(coder: coder)
        setup()
    }

    func update(withConfig config: AndesMoneyAmountViewConfig, andCurrencyAdditionalOptionalConfig helperConfig: CurrencyAdditionalOptionalConfig) {
        self.config = config
        self.currencyAdditionalOptionalConfig = helperConfig
        updateView()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        createLabel()
        updateView()
    }

    private func createLabel() {
        label = UILabel()
        label?.translatesAutoresizingMaskIntoConstraints = false

        if let label = self.label {
            addSubview(label)
        }

        labelLeadingConstraint = label?.autoPinEdge(toSuperviewEdge: .leading, withInset: 0)
        labelTrailingConstraint = label?.autoPinEdge(toSuperviewEdge: .trailing, withInset: 0)
        label?.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        label?.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

        labelLeadingConstraint?.isActive = true
        labelTrailingConstraint?.isActive = true
    }

    private func createLabelSuffix() {
        guard let suffix = currencyAdditionalOptionalConfig.suffix, let suffixAttributedString = suffix.suffix else {
            return
        }

        let suffixFont = currencyAdditionalOptionalConfig.semiBold ?
                        AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: suffix.suffixSize) :
                        AndesStyleSheetManager.styleSheet.regularSystemFont(size: suffix.suffixSize)

        let suffixString = NSMutableAttributedString(string: "/")
        suffixString.append(suffixAttributedString)

        labelSuffix = UILabel()
        labelSuffix?.translatesAutoresizingMaskIntoConstraints = false

        labelSuffix?.textColor = AndesStyleSheetManager.styleSheet.textColorSecondary
        labelSuffix?.font = suffixFont

        labelSuffix?.attributedText = suffixString

        if let labelSuffix = self.labelSuffix {
            addSubview(labelSuffix)
        }

        guard let label = self.label else { return }

        labelSuffix?.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: suffix.suffixPadding).isActive = true
        labelSuffix?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        labelSuffix?.autoAlignAxis(.horizontal, toSameAxisOf: label)
        labelTrailingConstraint?.isActive = false

        labelSuffix?.setContentHuggingPriority(.defaultLow, for: .horizontal)
        labelSuffix?.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)

        label.setNeedsLayout()
        label.layoutIfNeeded()
    }

    private func createImage() {
        guard let currencyIcon = currencyAdditionalOptionalConfig.currencyIcon, let icon = currencyIcon.currencyIcon else {
            return
        }

        currencyImage = UIImageView()
        currencyImage?.translatesAutoresizingMaskIntoConstraints = false

        if let image = self.currencyImage { addSubview(image) }

        currencyImage?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        currencyImage?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        currencyImage?.widthAnchor.constraint(equalToConstant: currencyIcon.currencyIconSize).isActive = true
        currencyImage?.heightAnchor.constraint(equalToConstant: currencyIcon.currencyIconSize).isActive = true

        labelLeadingConstraint?.constant = currencyIcon.currencyIconSize + currencyIcon.currencyIconPadding

        AndesIconsProvider.loadIcon(name: icon) { icon in
            self.currencyImage?.image = icon
        }
    }

    func updateView() {
        guard let amountItems = separateDecimals() else { return }

        let andesFont = currencyAdditionalOptionalConfig.semiBold ?
                        AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: config.sizes.labelSize) :
                        AndesStyleSheetManager.styleSheet.regularSystemFont(size: config.sizes.labelSize)

        var amountValue = config.decimalStyle == .none ? amountItems.integer : config.amount
        amountValue = config.type == .negative ? "- " + amountValue : amountValue

        var attributedAmount = NSMutableAttributedString(string: amountValue, attributes: [.font: andesFont])

        let textColorPrimary = AndesStyleSheetManager.styleSheet.textColorPrimary
        let textColorSecondary = AndesStyleSheetManager.styleSheet.textColorSecondary
        label?.textColor = config.type != .previous ? textColorPrimary : textColorSecondary

        if config.type == .previous {
            let previousAttString = setUpPrevious(with: attributedAmount, amount: amountValue)
            attributedAmount = previousAttString
        }

        if config.decimalStyle == .superScript, amountItems.decimal != "" {
            let superScriptAttString = configureSuperScript(attString: attributedAmount, amount: amountValue)
            attributedAmount = superScriptAttString
            if config.type == .previous {
                let previousAttString = setUpPrevious(with: attributedAmount, amount: amountValue)
                attributedAmount = previousAttString
            }

            let location = amountValue.count - (amountItems.decimal.count + 1)
            attributedAmount.replaceCharacters(in: NSRange(location: location, length: 1), with: "")
        }

        label?.attributedText = attributedAmount

        labelLeadingConstraint?.constant = 0
        currencyImage?.removeFromSuperview()
        currencyImage = nil

        labelSuffix?.removeFromSuperview()
        labelSuffix = nil

        if let currencyIcon = currencyAdditionalOptionalConfig.currencyIcon, let icon = currencyIcon.currencyIcon {
            if currencyAdditionalOptionalConfig.showIcon && !icon.isEmpty {
                self.createImage()
            }
        }

        if config.sizes.labelSize > 12 {
            self.createLabelSuffix()
        }

        if let textColor = currencyAdditionalOptionalConfig.textColor {
            label?.textColor = textColor
            labelSuffix?.textColor = textColor
        }
    }

    private func configureSuperScript(attString: NSMutableAttributedString, amount: String) -> NSMutableAttributedString {
        let superScriptAttString = attString

        let andesSuperScriptFont = currencyAdditionalOptionalConfig.semiBold ?
                                    AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: config.sizes.superScriptSize) :
                                    AndesStyleSheetManager.styleSheet.regularSystemFont(size: config.sizes.superScriptSize)

        superScriptAttString.setAttributes(
            [.font: andesSuperScriptFont, .baselineOffset: (config.sizes.superScriptSize * 0.65)],
            range: NSRange(location: amount.count - 2, length: 2)
        )
        superScriptAttString.addAttribute(.kern, value: 1, range: NSRange(location: amount.count - 3, length: 1))
        return superScriptAttString
    }

    private func setUpPrevious(with attString: NSMutableAttributedString, amount: String) -> NSMutableAttributedString {
        let previousAttString = attString
        previousAttString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: amount.count - 2, length: 2))

        previousAttString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: amount.count - 2 ))
        return previousAttString
    }

    private func separateDecimals() -> (integer: String, decimal: String)? {
        var amountItems: (integer: String, decimal: String) = ("", "")

        let separator = CharacterSet(charactersIn: config.decimalSeparator)
        let arrayOfAmountItems = config.amount.components(separatedBy: separator)

        if let firstItem = arrayOfAmountItems.first,
           let lastItem = arrayOfAmountItems.last {
            amountItems = (firstItem, firstItem == lastItem ? "" : lastItem)
        }

        return amountItems
    }
}
