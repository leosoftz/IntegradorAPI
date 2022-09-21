//
//  
//  AndesSwitch.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 21/06/21.
//
//

import Foundation

@objc public class AndesSwitch: UIView, AndesAccessibleView {
    internal var contentView: AndesSwitchView!

    @objc public var type: AndesSwitchType = .enable {
        didSet {
            updateContentView()
        }
    }

    @objc public var status: AndesSwitchStatus = .unchecked {
        didSet {
            updateContentView()
        }
    }

    @objc public var align: AndesSwitchAlign = .right {
        didSet {
            updateContentView()
        }
    }

    @objc public var text: String = "" {
        didSet {
            updateContentView()
        }
    }

    /// Sets the number of lines the title of the RadioButton
    @objc public var titleNumberOfLines: Int = 0 {
        didSet {
            self.updateContentView()
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(type: AndesSwitchType, status: AndesSwitchStatus, align: AndesSwitchAlign, text: String) {
        super.init(frame: .zero)
        self.type = type
        self.status = status
        self.align = align
        self.text = text
        setup()
    }

    override public func accessibilityActivate() -> Bool {
        accessibilityManager?.accessibilityActivated()
        return true
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
        accessibilityManager = AndesSwitchAccessibilityManager(view: self)
    }

    private func drawContentView(with newView: AndesSwitchView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesSwitchViewConfigFactory.provideInternalConfig(andesSwitch: self)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesSwitchView {
        let config = AndesSwitchViewConfigFactory.provideInternalConfig(andesSwitch: self)
        return AndesSwitchViewDefault(withConfig: config, delegate: self)
    }

    /// Callback invoked when switch  is tapped
    internal var onChangeState: ((AndesSwitch) -> Void)?

    /// Set dismiss callback to be invoked when checkbox button is pressed
    @objc public func setChangeState(callback: @escaping ((AndesSwitch) -> Void)) {
        self.onChangeState = callback
    }
}

// MARK: - IB interface
public extension AndesSwitch {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibType: String {
        set(val) {
            self.type = AndesSwitchType.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.type.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'status' instead.")
    @IBInspectable var ibStatus: String {
        set(val) {
            self.status = AndesSwitchStatus.checkValidEnum(property: "IB status", key: val)
        }
        get {
            return self.status.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'align' instead.")
    @IBInspectable var ibAlign: String {
        set(val) {
            self.align = AndesSwitchAlign.checkValidEnum(property: "IB align", key: val)
        }
        get {
            return self.align.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'text' instead.")
    @IBInspectable var ibText: String {
        set(val) {
            self.text = val
        }
        get {
            return self.text
        }
    }
}

extension AndesSwitch: AndesSwitchViewDelegate {
    func OnStatusChange() {
        switch self.status {
        case .checked:
            self.status = .unchecked
        case .unchecked:
            self.status = .checked
        }

        updateContentView()
        onChangeState?(self)
    }
}
