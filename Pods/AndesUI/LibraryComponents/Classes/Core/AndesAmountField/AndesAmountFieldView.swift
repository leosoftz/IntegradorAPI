//
//  AndesAmountFieldView.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 18/02/2022.
//

import UIKit
import PureLayout

@objc
public class AndesAmountFieldView: UIView, UIKeyInput {
    @objc
    public weak var delegate: AndesAmountFieldDelegate?
    fileprivate var displayView: AndesAmountFieldDisplayView?
    private var processValue: AndesAmountFieldInputManager
    private var isFirstTime: Bool = true
    @objc
    public var actualValueString: String {
        self.processValue.actualValueRepresentation
    }

    @objc
    public var actualValueDecimal: Decimal {
        self.processValue.actualValueDecimalRepresentation
    }

    private let group = DispatchGroup()

    private var accessibilityManager: AndesAccessibilityManager?

    fileprivate var editMode = false

    private var groupEdit = false

    private var isInitial: Bool = true
    override public var canBecomeFirstResponder: Bool {
        self.isEnabled
    }
    @objc
    public var isEnabled: Bool = true {
        didSet {
            if isEnabled {
                self.setupTap()
            } else {
                _ = self.resignFirstResponder()
                self.disableTap()
            }
        }
    }

    private(set) var config: AndesAmountFieldConfig
    private(set) var input = AndesAmountFieldInputConfig(type: .currency, entryMode: .fromDecimal, decimalSeparator: ",", groupingSeparator: ".", groupingSize: 3, decimalPlaces: 2)
    private(set) var textConfig = AndesAmountFieldTextConfig(currencySymbol: "$", suffixText: "/día")
    private(set) var limits = AndesAmountFieldInputLimits(maxValue: Decimal(10000))
    private(set) var initialValue = Decimal(0)

    private var tapForFocus: UITapGestureRecognizer?
    private var longPressPaste: UILongPressGestureRecognizer?

    @objc
    override init(frame: CGRect) {
        self.config = AndesAmountFieldConfig(inputConfig: self.input, inputLimits: self.limits, textConfig: self.textConfig)
        self.displayView = AndesAmountFieldDisplayView(type: self.config.inputConfig.type, textConfig: self.config.textConfig, isCursorAlwaysToTheRight: self.config.inputConfig.entryMode == .fromDecimal)
        self.processValue = AndesAmountFieldInputManager(initialValue: initialValue, config: self.config)
        super.init(frame: frame)
        self.showAsNormal(text: "")
        self.setup(with: config, value: initialValue, isPlaceHolder: true)
    }

    @objc
    public convenience init(config: AndesAmountFieldConfig, initialValue: Decimal) {
        self.init(frame: CGRect.zero)
        self.setup(with: config, value: initialValue, isPlaceHolder: true)
    }

    required init?(coder: NSCoder) {
        self.config = AndesAmountFieldConfig(inputConfig: self.input, inputLimits: self.limits, textConfig: self.textConfig)
        self.displayView = AndesAmountFieldDisplayView(type: self.config.inputConfig.type, textConfig: self.config.textConfig, isCursorAlwaysToTheRight: self.config.inputConfig.entryMode == .fromDecimal)
        self.processValue = AndesAmountFieldInputManager(initialValue: initialValue, config: self.config)
        super.init(coder: coder)
        self.showAsNormal(text: "")
        self.setup(with: config, value: initialValue, isPlaceHolder: true)
    }

    @objc
    public func setup(with config: AndesAmountFieldConfig, value: Decimal, isPlaceHolder: Bool) {
        self.isInitial = isPlaceHolder
        self.gestureRecognizers?.forEach(removeGestureRecognizer(_:))
        self.accessibilityManager = AndesAmountFieldAccessibilityManager(view: self)
        self.displayView?.removeFromSuperview()
        self.config = config
        self.initialValue = value >= 0 ? value : 0
        self.displayView = AndesAmountFieldDisplayView(type: self.config.inputConfig.type, textConfig: self.config.textConfig, isCursorAlwaysToTheRight: self.config.inputConfig.entryMode == .fromDecimal)
        self.isEnabled = true
        self.setupViews()
        self.processValue = AndesAmountFieldInputManager(initialValue: initialValue, config: self.config)
        self.setupTap()
    }

    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.Andes.white
        guard let displayView = displayView else { return }
        self.addSubview(displayView)
        displayView.autoPinEdgesToSuperviewEdges()
        self.isUserInteractionEnabled = true
        self.accessibilityIdentifier = "AMOUNT_FIELD_VIEW"
    }

    private func setupTap() {
            disableTap()
            self.tapForFocus = UITapGestureRecognizer(target: self, action: #selector(shortPressHandler))
            if let tapForFocus = tapForFocus {
                tapForFocus.numberOfTapsRequired = 1
                self.addGestureRecognizer(tapForFocus)
            }
    }

    private func disableTap() {
        if let tapForFocus = self.tapForFocus {
            self.removeGestureRecognizer(tapForFocus)
            self.tapForFocus = nil
        }
    }

    private func enablePasteMenu() {
        if UIAccessibility.isVoiceOverRunning {
            let paste = UIAccessibilityCustomAction(
              name: "Paste",
              target: self,
              selector: #selector(doPaste))
              self.accessibilityCustomActions = [paste]
        } else {
            if let longPressPaste = self.longPressPaste {
                self.removeGestureRecognizer(longPressPaste)
            }
            self.longPressPaste = UILongPressGestureRecognizer(target: self, action: #selector(longPressHandler))
            if let longPressPaste = self.longPressPaste {
                longPressPaste.minimumPressDuration = 0.1 // how long before menu pops up
                self.addGestureRecognizer(longPressPaste)
            }
        }
    }

    public  var keyboardType: UIKeyboardType {
        get { return .decimalPad }
        set { }
    }

    public var hasText: Bool {
        actualValueString.isEmpty == false
    }

    private func transformDotToDecimalSeparator(text: String) -> String {
        if text == "." {
            return self.config.inputConfig.decimalSeparator
        } else {
            return text
        }
    }

    public func insertText(_ text: String) {
        UIMenuController.shared.hideMenu()
        if self.isEnabled && self.groupEdit == false {
            group.enter()
            let filterText = self.transformDotToDecimalSeparator(text: text)
            _ = self.processValue.format(input: filterText)
            self.updateView()
        }
    }

    public func deleteBackward() {
        UIMenuController.shared.hideMenu()
        if self.isEnabled && self.groupEdit == false {
            group.enter()
            _ = processValue.deleteBackward()
            self.updateView()
        }
    }

    @objc
    func shortPressHandler(sender: UITapGestureRecognizer) {
       _ = self.becomeFirstResponder()
    }

    @objc
    func longPressHandler(sender: UILongPressGestureRecognizer) {
        guard sender.state == .began
        else { return }
        let saveMenuItem = UIMenuItem(title: "Paste", action: #selector(doPaste))
        UIMenuController.shared.menuItems = [saveMenuItem]
        guard let frameDisplay = self.displayView?.editViewFrame() else { return }
        let convertedFrame = self.convert(frameDisplay, to: self).offsetBy(dx: 0, dy: 24)
        // Tell the menu controller the first responder's frame and its super view
        // Animate the menu onto view
        UIMenuController.shared.showMenu(from: self, rect: convertedFrame)
    }

    @objc
    public func doPaste() {
        if self.isEnabled && self.groupEdit == false {
            group.enter()
            guard let pastedValue = UIPasteboard.general.string else { return }
            let filterNumberUtil = AndesAmountFieldFilterNumberUtil(inputConfig: input, maxValue: self.config.inputLimits.maxValue)
            let cleanValue = filterNumberUtil.clean(inputText: pastedValue)
            _ = processValue.formatInputFrom(pastedDecimal: cleanValue)
            self.updateView()
        }
    }

    private func updateView() {
        DispatchQueue.main.async {
            self.isInitial = false
            self.accessibilityManager?.viewUpdated()
            self.groupEdit = true
            self.draw(self.bounds) // instead of self.setNeedsDisplay() the test does not trigger it or can't leave the group
        }

        // does not wait. But the code in notify() gets run
        // after enter() and leave() calls are balanced
        group.notify(queue: .main) {
            guard let delegate = self.delegate else { return }
            delegate.amountFieldDidChage(amountField: self, stringValue: self.actualValueString, decimalValue: self.actualValueDecimal)
            self.groupEdit = false
        }
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.displayView?.update(showText: self.actualValueString, number: self.actualValueDecimal, initial: self.isInitial)
        if groupEdit {
            group.leave()
        }
    }

    private func shake() {
        self.displayView?.shake()
    }

    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        if isEnabled {
            if !self.isFirstTime {
                self.shake()
            }
            self.enablePasteMenu()
            if let tapForFocus = tapForFocus {
                self.removeGestureRecognizer(tapForFocus)
            }
            self.editMode = true
            self.accessibilityManager?.viewUpdated()
        }
        return canBecomeFirstResponder
    }

    override public func resignFirstResponder() -> Bool {
        self.displayView?.hideCursor()
        super.resignFirstResponder()
        if let longPressPaste = self.longPressPaste {
            self.removeGestureRecognizer(longPressPaste)
        }
        self.editMode = false
        self.accessibilityManager?.viewUpdated()
        self.setupTap()
        return true
    }

    override public func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        self.isFirstTime = false
        if self.isFirstResponder {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.shake()
            }
        }
    }

    @objc
    override public var intrinsicContentSize: CGSize {
        self.displayView?.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: displayView?.bounds.height ?? 0)
    }

    override public class var requiresConstraintBasedLayout: Bool {
        return true
    }

    fileprivate func generalA11yText() -> String {
        return self.displayView?.valuesTextForA11y() ?? ""
    }
}

extension AndesAmountFieldView: AndesAmountFieldRefreshableView {
    func refresh() {
        if self.isEnabled && self.groupEdit == false {
            group.enter()
            self.updateView()
        }
    }
}

extension AndesAmountFieldView: AndesAmountFieldDisplayViewProtocol {
    @objc
    public func showAsError(text: String) {
        self.displayView?.delegateUpdate = self
        self.displayView?.showAsError(text: text)
        self.accessibilityManager?.viewUpdated()
        if let a11yManag = self.accessibilityManager as? AndesAmountFieldAccessibilityManager {
            a11yManag.makeHelperAnnuncementError(text: text)
        }
    }
    @objc
    public func showAsNormal(text: String) {
        self.displayView?.showAsNormal(text: text)
        self.accessibilityManager?.viewUpdated()
    }
}

private class AndesAmountFieldAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesAmountFieldView!
    required init(view: UIView) {
        guard let amountfield = view as? AndesAmountFieldView else {
            fatalError("AndesAmountFieldAccesibilityManager must recieve an AndesAmountFieldView")
        }
        self.view = amountfield
        viewUpdated()
    }

    func viewUpdated() {
        self.view.accessibilityTraits = .none
        self.view.displayView?.enableA11yEditNumberView(enable: view.editMode)
        self.view.accessibilityHint = "Toque dos veces para editar".localized()
        self.view.accessibilityLabel = createAccessibilityLabel(amountfield: view)
        self.view.isAccessibilityElement = !view.editMode
    }

    func accessibilityActivated() {
        view.becomeFirstResponder()
    }

    func makeHelperAnnuncementError(text: String) {
        makeAnnouncement(type: .message(message: "Error".localized() + "," + text))
    }

    func makeHelperAnnuncementNormal(text: String) {
        makeAnnouncement(type: .message(message: text))
    }

    private func createAccessibilityLabel(amountfield: AndesAmountFieldView) -> String {
        let accessibilityLabel = self.view.generalA11yText()
        return accessibilityLabel
    }
}
