//
//  AndesAmountFieldSuffix.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 23/02/2022.
//

import UIKit

class AndesAmountFieldSuffixView: AndesLabel {
    private var fontStyleTitle: AndesFontStyle

    init(text: String, style: AndesFontStyle) {
        self.fontStyleTitle = style
        super.init(frame: CGRect.zero)
        self.text = text
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.numberOfLines = 1
        self.backgroundColor = UIColor.clear(debug: UIColor.orange)
        self.update(style: self.fontStyleTitle)
        self.accessibilityIdentifier = "AMOUNT_FIELD_SUFFIX_VIEW"
        self.isAccessibilityElement = false
    }

    public func update(style: AndesFontStyle) {
        self.fontStyleTitle = style
        self.setTextStyle()
    }

    private func setTextStyle() {
        let internalConfig = AndesLabelInternalConfig(size: self.fontStyleTitle.font.pointSize, lineHeight: self.fontStyleTitle.fontLineHeight, color: self.fontStyleTitle.textColor, bodyLinks: nil, bodyBolds: nil, isLinkColorInverted: false)
        self.setStyleAsInternal(internalConfig: internalConfig)
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
