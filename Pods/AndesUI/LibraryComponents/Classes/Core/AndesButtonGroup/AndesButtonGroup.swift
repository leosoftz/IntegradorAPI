//
//  
//  AndesButtonGroup.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import Foundation

@objc
public class AndesButtonGroup: UIView {
    internal var contentView: AndesButtonGroupView!

    @objc
    public var buttonList: [AndesButton] = [] {
        didSet {
            if buttonList.count == 0 {
                FatalErrorUtil.fatalErrorClosure("The component requires at least one AndesButton", #file, #line)
            } else if buttonList.count > 3 {
                FatalErrorUtil.fatalErrorClosure("The component does not support more than three AndesButton", #file, #line)
            }

            updateContentView()
        }
    }

    @objc
    public var type: AndesButtonGroupType = .fullWidth {
        didSet {
            updateContentView()
        }
    }

    @objc
    public var distribution: AndesButtonGroupDistribution = .horizontal {
        didSet {
            updateContentView()
        }
    }

    @objc
    public var align: AndesButtonGroupAlign = .left {
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

    @objc
    public init(buttonList: [AndesButton], type: AndesButtonGroupType = .fullWidth, distribution: AndesButtonGroupDistribution = .horizontal, align: AndesButtonGroupAlign = .left) {
        super.init(frame: .zero)
        self.buttonList = buttonList
        self.type = type
        self.distribution = distribution
        self.align = align
        setup()
    }

    @objc
    public func fullwidth() {
        self.type = .fullWidth
    }

    @objc
    public func responsive(align: AndesButtonGroupAlign) {
        self.type = .responsive
        self.align = align
    }

    @objc
    public func setButtons(buttonList: [AndesButton]) {
        self.buttonList = buttonList
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesButtonGroupView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        let config = AndesButtonGroupViewConfigFactory.provideInternalConfig(type: self.type, distribution: self.distribution, align: self.align, buttonList: self.buttonList)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesButtonGroupView {
        let config = AndesButtonGroupViewConfigFactory.provideInternalConfig(type: self.type, distribution: self.distribution, align: self.align, buttonList: self.buttonList)
        return AndesButtonGroupViewDefault(withConfig: config)
    }
}
