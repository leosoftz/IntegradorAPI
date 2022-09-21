//
//  AndesAmountFieldDisplayView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 23/02/2022.
//

import UIKit

class AndesAmountFieldDisplayView: UIView {
    private lazy var stackView: UIStackView = buildStackView()
    private var editView: AndesAmountFieldEditView
    private var helperView: AndesAmountFieldHelperView

    weak var delegateUpdate: AndesAmountFieldRefreshableView?

    internal func editViewFrame() -> CGRect {
        return self.editView.frame
    }

    init(type: AndesAmountFieldType, textConfig: AndesAmountFieldTextConfig, isCursorAlwaysToTheRight: Bool) {
        self.editView = AndesAmountFieldEditView(type: type, textConfig: textConfig, isCursorAlwaysToTheRight: isCursorAlwaysToTheRight)
        self.helperView = AndesAmountFieldHelperView()
        super.init(frame: CGRect.zero)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.editView)
        self.stackView.addArrangedSubview(self.helperView)
        self.stackView.autoPinEdgesToSuperviewEdges()
        self.hideCursor()
    }

    private func buildStackView() -> UIStackView {
        let stack = UIStackView(forAutoLayout: ())
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.backgroundColor = UIColor.clear
        return stack
    }

    public func update(showText: String, number: Decimal, initial: Bool) {
        editView.update(showText: showText, number: number, initial: initial)
        editView.layoutIfNeeded()
    }

    public func shake() {
        editView.shake()
    }

    public func hideCursor() {
        self.editView.hideCursor()
    }

    public func showCursor() {
        self.editView.showCursor()
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    func valuesTextForA11y() -> String {
        var values = self.editView.valuesTextForA11y()
        values.helperText = self.helperView.state.textA11y()
        return values.generalA11yText()
    }

    func helpTestState() -> AndesAmountFieldHelperStateEnum {
        return self.helperView.state
    }

    func enableA11yEditNumberView(enable: Bool) {
        self.editView.enableA11yEditNumberView(enable: enable)
    }
}

extension AndesAmountFieldDisplayView: AndesAmountFieldDisplayViewProtocol {
    @objc
    func showAsNormal(text: String) {
        self.helperView.showAsNormal(text: text)
    }

    @objc
    public func showAsError(text: String) {
        self.editView.refreshableView = self
        self.helperView.showAsError(text: text)
        self.editView.showAsError()
    }
}

extension AndesAmountFieldDisplayView: AndesAmountFieldRefreshableView {
    func refresh() {
        self.delegateUpdate?.refresh()
    }
}
