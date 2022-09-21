//
//  AndesInputStepper.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 19/01/22.
//

import UIKit

@IBDesignable
public class AndesInputStepper: UIView {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'Size' instead.")
    @IBInspectable var ibSize: String {
        get {
            return self.size.toString()
        }
        set(val) {
            self.size = AndesInputStepperSize.checkValidEnum(property: "IB size", key: val)
        }
    }

    @objc public var size: AndesInputStepperSize = DefaultsInputStepper.size {
        didSet {
            setup(config: createConfig())
        }
    }

    @IBInspectable
    public var maxValue: Int = DefaultsInputStepper.maxValue {
        didSet {
            setup(config: createConfig())
        }
    }

    @IBInspectable
    public var minValue: Int = DefaultsInputStepper.minValue {
        didSet {
            setup(config: createConfig())
        }
    }

    @IBInspectable
    public var step: Int = DefaultsInputStepper.step {
        didSet {
            self.inputStepperView.config.step = self.step
        }
    }

    @objc public var currentValue: Int {
        get {
            self.inputStepperView.config.value
        }
        set {
            let value = getCorrectValue(value: newValue)
            self.inputStepperView.config.value = value
        }
    }

    @objc public var loading: Bool = DefaultsInputStepper.loading {
        didSet {
            self.inputStepperView.isLoading = loading
        }
    }

    @objc public var enabled: Bool = DefaultsInputStepper.enabled {
        didSet {
            self.inputStepperView.isEnabled = enabled
        }
    }

    @objc public weak var delegate: AndesInputStepperDelegate?
    @objc public weak var dataSource: AndesInputStepperTextDataSource?

    private var inputStepperView: AndesInputStepperView = AndesInputStepperDefaultView(config: DefaultsInputStepper.createConfig())
    var heightAnchorConstraint: NSLayoutConstraint?

    override public func prepareForInterfaceBuilder() {
        setup(config: createConfig())
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(config: createConfig())
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(config: createConfig())
    }

    @objc public init(size: AndesInputStepperSize = DefaultsInputStepper.size,
                      maxValue: Int = DefaultsInputStepper.maxValue,
                      minValue: Int = DefaultsInputStepper.minValue,
                      step: Int = DefaultsInputStepper.step) {
        super.init(frame: .zero)
        self.size = size
        self.maxValue = maxValue
        self.minValue = minValue
        self.step = step
        setup(config: createConfig())
    }

    private func createConfig() -> AndesInputStepperViewConfig {
        return AndesInputStepperViewConfigFactory.provideInternalConfig(
            size: self.size,
            maxValue: self.maxValue,
            minValue: self.minValue,
            step: self.step,
            value: self.minValue)
    }

    private func setup(config: AndesInputStepperViewConfig) {
        removeAllViews()
        setupContentViewHeight(config: config)
        setupContentView(config: config)
    }

    private func removeAllViews() {
        subviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    private func setupContentViewHeight(config: AndesInputStepperViewConfig) {
        translatesAutoresizingMaskIntoConstraints = false
        if  let heightAnchorConstraint = self.heightAnchorConstraint {
            heightAnchorConstraint.constant = config.size.height
            layoutIfNeeded()
        } else {
            heightAnchorConstraint = self.heightAnchor.constraint(equalToConstant: config.size.height)
            heightAnchorConstraint?.isActive = true
        }
    }

    private func setupContentView(config: AndesInputStepperViewConfig) {
        self.inputStepperView = createInputStepperView(config: config)
        addSubview(self.inputStepperView)
        self.inputStepperView.updateInputStepperConstraints()
    }

    private func createInputStepperView(config: AndesInputStepperViewConfig) -> AndesInputStepperView {
        return AndesInputStepperDefaultView(config: config, delegate: self, dataSource: self)
    }

    private func getCorrectValue(value: Int) -> Int {
        if value > self.maxValue {
            return self.maxValue
        } else if value < self.minValue {
            return self.minValue
        } else {
            return value
        }
    }
}

extension AndesInputStepper: AndesInputStepperViewDelegate {
    func andesInputStepperView(_ inputStepper: AndesInputStepperView, didSelect value: Int, state: AndesInputStepperState, sender: AndesInputStepperSender) {
        self.delegate?.andesInputStepper(self, didSelect: value, state: state, sender: sender)
    }
}

extension AndesInputStepper: AndesInputStepperViewTextDataSource {
    func andesInputStepperView(_ inputStepper: AndesInputStepperView, textFor value: Int) -> NSAttributedString? {
        guard let dataSource = self.dataSource else {
            return NSAttributedString(string: String(value))
        }
        return dataSource.andesInputStepper(self, textFor: value)
    }
}
