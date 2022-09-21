//
//  
//  AndesButtonGroupAbstractView.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 15/03/22.
//
//

import UIKit

class AndesButtonGroupAbstractView: UIView, AndesButtonGroupView {
    private lazy var componentView: UIStackView = {
        return self.buildStackView()
    }()

    private(set) var config: AndesButtonGroupViewConfig

    private var componentViewConstraints: [NSLayoutConstraint] = []

    init(withConfig config: AndesButtonGroupViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.config = AndesButtonGroupViewConfig()
        super.init(coder: coder)
        setup()
    }

    func update(withConfig config: AndesButtonGroupViewConfig) {
        self.config = config
        self.updateView()
    }

    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.componentView)
        self.updateView()
    }

    private func buildStackView() -> UIStackView {
        let stack = UIStackView(forAutoLayout: ())
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.backgroundColor = UIColor.clear
        return stack
    }

    private func setupStackView() {
        removeButtons()
        configureAxisStackView()

        if config.distribution == .vertical || config.type == .fullWidth {
            pinEdgesToSuperviewMargins()
        }

        if config.type == .responsive {
            componentView.distribution = .fillProportionally
            configureAlignStackView()
        } else {
            componentView.distribution = .fillEqually
        }

        guard let firstButton = config.buttonList.first else {
            return
        }

        let buttonSize = firstButton.size
        configurePaddingButtons(buttonSize: buttonSize)
        configureButtons(buttonSize: buttonSize)
    }

    private func configurePaddingButtons(buttonSize: AndesButtonSize) {
        let padding = AndesButtonGroupPaddingFactory.provide(buttonSize)
        componentView.spacing = padding.paddingSize
    }

    private func configureAxisStackView() {
        switch config.distribution {
        case .horizontal:
            componentView.axis = .horizontal
            break
        case .vertical:
            componentView.axis = .vertical
            break
        }
    }

    private func pinEdgesToSuperviewMargins() {
        let constrains = componentView.autoPinEdgesToSuperviewMargins()
        for item in constrains {
            componentViewConstraints.append(item)
        }
    }

    private func removeConstraints() {
        self.componentView.removeConstraints(self.componentViewConstraints)
        self.componentViewConstraints.removeAll()
    }

    private func addComponentViewConstraints(_ constrains: [NSLayoutConstraint]) {
        constrains.forEach({ self.componentViewConstraints.append($0) })
    }

    private func configureAlignStackView() {
        switch config.align {
        case .left:
            if config.distribution == .vertical {
                componentView.alignment = .leading
            } else {
                let constrains = componentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .trailing)
                addComponentViewConstraints(constrains)
            }
            break
        case .right:
            if config.distribution == .vertical {
                componentView.alignment = .trailing
            } else {
                let constrains = componentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .leading)
                addComponentViewConstraints(constrains)
            }
            break
        case .center:
            if config.distribution == .vertical {
                componentView.alignment = .center
            } else {
                let constrainTop = componentView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)

                let constrainBottom = componentView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)

                let constrainsCenter = componentView.autoCenterInSuperview()

                addComponentViewConstraints([constrainTop, constrainBottom])
                addComponentViewConstraints(constrainsCenter)
            }
            break
        }
    }

    private func removeButtons() {
        for view in componentView.subviews {
            view.removeFromSuperview()
        }
    }

    private func configureButtons(buttonSize: AndesButtonSize) {
        for button in config.buttonList {
            button.size = buttonSize
            componentView.addArrangedSubview(button)
        }
    }

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        removeConstraints()
        setupStackView()
        self.layoutMargins = .zero
    }
}
