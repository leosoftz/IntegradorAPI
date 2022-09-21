//
//
//  AndesSteppedSlider.swift
//  AndesUI
//
//  Created by Victor Chang on 27/04/2021.
//
//

import UIKit

@objc public protocol AndesSteppedSliderDelegate {
    @objc func onValueChanged(steppedSlider: AndesSteppedSlider)
}

@objc public class AndesSteppedSlider: UIView {
    @objc public weak var delegate: AndesSteppedSliderDelegate?

    internal var contentView: AndesSliderView!

    // MARK: - User properties

    @objc public var value: Double = 0 {
        didSet {
            updateContentView()
        }
    }

    @objc public var valueText: String? {
        didSet {
            updateContentView()
        }
    }

    @objc public var type: AndesSliderType = .simple {
        didSet {
            updateContentView()
        }
    }

    @objc public var handleType: AndesSliderHandleType = .singleType {
        didSet {
            updateContentView()
        }
    }

    @objc public var tooltipEnabled: Bool = false {
        didSet {
            updateContentView()
        }
    }

    @objc public var leftIcon: String? {
        didSet {
            updateContentView()
        }
    }
    @objc public var rightIcon: String? {
        didSet {
            updateContentView()
        }
    }

    // MARK: - Slider's Limit Values
    public var sliderMinValue: Double? {
        didSet {
            updateContentView()
        }
    }
    public var sliderMaxValue: Double? {
        didSet {
            updateContentView()
        }
    }

    // the current state of the slider
    @objc public var state: AndesSliderState = .idle {
        didSet {
            updateContentView()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public var numberOfSteps: Int? = 5 {
        didSet {
            updateContentView()
        }
    }

    @objc public init(numberOfSteps: Int, type: AndesSliderType, minValue: Double, maxValue: Double) {
        super.init(frame: .zero)
        self.numberOfSteps = numberOfSteps
        self.type = type
        setup()
    }

    // MARK: - Content View Setup

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        let config = AndesSliderViewConfigFactory.provideInternalConfig(forSteppedSlider: self)
        contentView = AndesSliderSteppedView(withConfig: config, delegate: self)
        self.addSubview(contentView)
        contentView.pinToSuperview()
        self.value = config.value
        self.valueText = config.valueText
        self.sliderMinValue = config.minValue
        self.sliderMaxValue = config.maxValue
        self.tooltipEnabled = config.tooltipEnabled
        self.numberOfSteps = config.numberOfSteps ?? 0
        self.state = config.state
    }

    private func drawContentView(with newView: AndesSliderView) {
        contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    /// Check if view needs to be redrawn, and then update it. This method should be called on all modifiers that may need to change which internal view should be rendered
    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        }
        updateContentView()
    }

    private func updateContentView() {
        let config = AndesSliderViewConfigFactory.provideInternalConfig(forSteppedSlider: self)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesSliderView {
        let config = AndesSliderViewConfigFactory.provideInternalConfig(forSteppedSlider: self)
        return AndesSliderViewDefault(withConfig: config, delegate: self)
    }
}

extension AndesSteppedSlider: AndesSliderViewDelegate {
    func onValueChanged(value: Double, sender: UISlider) {
        self.value = value
        valueText = "\(value)"
        delegate?.onValueChanged(steppedSlider: self)
    }
}

// MARK: - IB interface
public extension AndesSteppedSlider {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibType: String {
        set(val) {
            self.type = AndesSliderType.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.type.toString()
        }
    }
}
