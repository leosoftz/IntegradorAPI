//
//  AndesAmountFieldEditableNumberView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 23/02/2022.
//

import UIKit

class AndesAmountFieldEditableNumberView: AndesLabel {
    private var fontStyleTitle: AndesFontStyle

    init(fontStyleTitle: AndesFontStyle) {
        self.fontStyleTitle = fontStyleTitle
        super.init(frame: CGRect.zero)
        self.text = "0" // text must something for the width
        self.setupViews()
        self.setTextStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .justified
        self.numberOfLines = 1
        self.backgroundColor = UIColor.clear(debug: UIColor.red.withAlphaComponent(0.7))
        self.isUserInteractionEnabled = false
        self.accessibilityIdentifier = "AMOUNT_FIELD_EDITABLE_NUMBER_VIEW"
        self.accessibilityTraits = .none
    }

    public func update(inputText: String, style: AndesFontStyle) {
        self.fontStyleTitle = style
        self.text = inputText
        self.setTextStyle()
        self.layoutIfNeeded()
        self.accessibilityLabel = createAccessibilityLabel()
    }

    private func setTextStyle() {
        let internalConfig = AndesLabelInternalConfig(size: self.fontStyleTitle.font.pointSize, lineHeight: self.fontStyleTitle.fontLineHeight, color: self.fontStyleTitle.textColor, bodyLinks: nil, bodyBolds: nil, isLinkColorInverted: false)
        self.setStyleAsInternal(internalConfig: internalConfig)
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    func a11y(enable: Bool) {
        self.isAccessibilityElement = enable
    }

    private func createAccessibilityLabel() -> String {
        var accessibilityLabel: String = ""
        accessibilityLabel += (self.text ?? "") + "," + "Campo de texto".localized()
        return accessibilityLabel
    }
}
