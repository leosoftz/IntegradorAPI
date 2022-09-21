//
//  
//  AndesRadioButtonGroup.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 10/06/21.
//
//

import Foundation

@objc public class AndesRadioButtonGroup: UIView {
    internal var contentView: AndesRadioButtonGroupView!

    @objc public var distribution: AndesRadioButtonGroupDistribution = .horizontal {
        didSet {
            updateContentView()
        }
    }

    @objc public var align: AndesRadioButtonAlign = .left {
        didSet {
            updateContentView()
        }
    }

    @objc public var selected: Int = -1 {
        didSet {
            updateContentView()
        }
    }

    @objc public var radioButtons: [AndesRadioButtonItem] = [] {
        didSet {
            updateContentView()
        }
    }

    @objc public var onRadioButtonCheckedChanged: ((Int) -> Void)?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @objc public init(selected: Int = -1, radioButtons: [AndesRadioButtonItem], align: AndesRadioButtonAlign, distribution: AndesRadioButtonGroupDistribution ) {
        super.init(frame: .zero)

        self.selected = selected
        self.radioButtons = radioButtons
        self.align = align
        self.distribution = distribution

        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesRadioButtonGroupView) {
        self.contentView = newView
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
        let config = AndesRadioButtonGroupViewConfigFactory.provideInternalConfig(
            distribution: distribution,
            align: align,
            selected: selected,
            radioButtons: radioButtons)

        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesRadioButtonGroupView {
        let config = AndesRadioButtonGroupViewConfigFactory.provideInternalConfig(
            distribution: distribution,
            align: align,
            selected: selected,
            radioButtons: radioButtons)
        let radioButtonGroupView = AndesRadioButtonGroupViewDefault(withConfig: config)
        radioButtonGroupView.componentDelegate = self
        return radioButtonGroupView
    }
}

// MARK: - IB interface
public extension AndesRadioButtonGroup {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'distribution' instead.")
    @IBInspectable var ibDistribution: String {
        set(val) {
            self.distribution = AndesRadioButtonGroupDistribution.checkValidEnum(property: "IB distribution", key: val)
        }
        get {
            return self.distribution.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'distribution' instead.")
    @IBInspectable var ibAlign: String {
        set(val) {
            self.align = AndesRadioButtonAlign.checkValidEnum(property: "IB Align", key: val)
        }
        get {
            return self.distribution.toString()
        }
    }
}

extension AndesRadioButtonGroup: AndesRadioButtonGroupDelegate {
    func didSelectIndex(_ index: Int) {
        self.selected = index
        self.onRadioButtonCheckedChanged?(index)
    }
}
