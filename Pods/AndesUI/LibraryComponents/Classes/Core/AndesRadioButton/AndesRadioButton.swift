//
//  AndesRadioButton.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/29/20.
//

import Foundation
import UIKit

@objc public class AndesRadioButton: UIView, AndesAccessibleView {
    internal var contentView: AndesRadioButtonView!

    /// Sets the title of the RadioButton
    @IBInspectable public var title: String? {
        didSet {
            self.updateContentView()
        }
    }

    /// Sets the number of lines the title of the RadioButton
    public var titleNumberOfLines: Int? {
        didSet {
            self.updateContentView()
        }
    }

    /// Sets the type of the RadioButton , default idle
    @objc public var type: AndesRadioButtonType = .idle {
        didSet {
            self.updateContentView()
        }
    }

    /// Sets the slign of the RadioButton , default left
    @objc public var align: AndesRadioButtonAlign = .left {
        didSet {
            self.updateContentView()
        }
    }

    /// Sets the status of the RadioButton , default unselected
    @objc public var status: AndesRadioButtonStatus = .unselected {
        didSet {
            self.updateContentView()
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    /// Callback invoked when RadioButton  is tapped
    internal var didTapped: ((AndesRadioButton) -> Void)?

    override public func accessibilityActivate() -> Bool {
        return accessibilityManager?.accessibilityActivated() != nil
    }

    /// Set dismiss callback to be invoked when checkbox button is pressed
    @objc public func setRadioButtonTapped(callback: @escaping ((AndesRadioButton) -> Void)) {
        self.didTapped = callback
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(type: AndesRadioButtonType, align: AndesRadioButtonAlign, status: AndesRadioButtonStatus, title: String) {
        super.init(frame: .zero)
        self.title = title
        self.type = type
        self.align = align
        self.status = status
        setup()
    }

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        let config = AndesRadioButtonConfig(for: self)
        contentView = AndesRadioButtonDefaultView(withConfig: config, delegate: self)
        self.addSubview(contentView)
        contentView.pinToSuperview()
        accessibilityManager = AndesRadioButtonAccessibilityManager(view: self)
    }

    private func updateContentView() {
        let config = AndesRadioButtonConfig(for: self)
        contentView.update(withConfig: config)
        accessibilityManager?.viewUpdated()
    }
}

extension AndesRadioButton: AndesRadioButtonViewDelegate {
    func radioButtonTapped() {
        guard let callback = self.didTapped else {
            return
        }
        switch self.type {
        case .error:
            self.type = .idle
            self.status = .selected
        case .idle:
            if self.status == .selected {
                self.status = .unselected
            } else if self.status == .unselected {
                self.status = .selected
            }
        case .disabled:
            // Never happen
            return
        }
        updateContentView()
        callback(self)
    }
}

// MARK: - IB interface
public extension AndesRadioButton {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibType: String {
        set(val) {
            self.type = AndesRadioButtonType.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.type.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'status' instead.")
    @IBInspectable var ibStatus: String {
        set(val) {
            self.status = AndesRadioButtonStatus.checkValidEnum(property: "IB status", key: val)
        }
        get {
            return self.status.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'align' instead.")
    @IBInspectable var ibAlign: String {
        set(val) {
            self.align = AndesRadioButtonAlign.checkValidEnum(property: "IB align", key: val)
        }
        get {
            return self.align.toString()
        }
    }
}
