//
//  AndesAmountFieldHelperView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 23/02/2022.
//

import UIKit

class AndesAmountFieldHelperView: UIView {
    private(set) var state: AndesAmountFieldHelperStateEnum = .normal(text: "")
    private lazy var stackView: UIStackView = buildStackView()
    private let titleLabel: AndesLabel
    private let backView: UIView
    private var iconView: UIImageView
    private var internalConfig: AndesLabelInternalConfig
    private var badge: UIView?

    private var text: String {
        didSet {
            self.titleLabel.text = self.text
            self.updateText()
        }
    }

    init() {
        self.backView = UIView(forAutoLayout: ())
        self.titleLabel = AndesLabel()
        self.iconView = UIImageView()
        self.internalConfig = AndesLabelInternalConfig(size: 13, lineHeight: 18, andesColor: .primary, bodyLinks: nil, bodyBolds: nil)
        self.text = ""
        super.init(frame: CGRect.zero)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func buildStackView() -> UIStackView {
        let stack = UIStackView(forAutoLayout: ())
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fillProportionally
        stack.spacing = 6
        stack.backgroundColor = UIColor.clear
        return stack
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(self.titleLabel)
        self.titleLabel.text = self.text
        self.titleLabel.textAlignment = .center
        self.backgroundColor = UIColor.clear(debug: UIColor.yellow)
        self.addSubview(self.stackView)
        self.stackView.autoPinEdge(toSuperviewEdge: .top)
        self.stackView.autoPinEdge(toSuperviewEdge: .bottom)
        self.stackView.autoMatch(.height, to: .height, of: self.titleLabel)
        self.stackView.autoPinEdge(toSuperviewEdge: .leading, withInset: 16, relation: .greaterThanOrEqual)
        self.stackView.autoPinEdge(toSuperviewEdge: .trailing, withInset: 16, relation: .greaterThanOrEqual)
        self.stackView.autoAlignAxis(toSuperviewAxis: .vertical)
        self.titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        self.titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        AndesIconsProvider.loadIcon(name: AndesIcons.feedbackError12, placeItInto: self.iconView)
        self.iconView.setImageColor(color: AndesStyleSheetManager.styleSheet.textColorWhite)
        self.titleLabel.isAccessibilityElement = false
        self.isAccessibilityElement = false
    }

    private func updateText() {
        self.titleLabel.numberOfLines = 0
        self.titleLabel.setStyleAsInternal(internalConfig: self.internalConfig)
    }
}

extension  AndesAmountFieldHelperView: AndesAmountFieldDisplayViewProtocol {
    public func showAsError(text: String) {
        self.state = .error(text: text)
        self.internalConfig = AndesLabelInternalConfig(size: 13, lineHeight: 18, andesColor: AndesLabelColor.negative, bodyLinks: nil, bodyBolds: nil)
        self.text = text
        self.removeBadge()
        self.badge = UIView(forAutoLayout: ())
        if let badge = self.badge {
            badge.backgroundColor = AndesStyleSheetManager.styleSheet.textColorNegative
            badge.layer.cornerRadius = 6
            badge.autoSetDimensions(to: CGSize(width: 12, height: 12))
            badge.addSubview(self.iconView)
            self.iconView.autoCenterInSuperview()
            self.backView.backgroundColor = UIColor.clear(debug: .brown)
            self.backView.addSubview(badge)
            badge.autoCenterInSuperview()
            self.stackView.insertArrangedSubview(self.backView, at: 0)
            self.backView.autoSetDimensions(to: CGSize(width: 12, height: 18))
        }
    }

    private func removeBadge() {
            self.stackView.removeArrangedSubview(self.backView)
            self.backView.removeFromSuperview()
            self.badge = nil
    }

    public func showAsNormal(text: String) {
        self.state = .normal(text: text)
        self.removeBadge()
        self.internalConfig = AndesLabelInternalConfig(size: 13, lineHeight: 18, andesColor: AndesLabelColor.secondary, bodyLinks: nil, bodyBolds: nil)
        self.text = text
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
}
