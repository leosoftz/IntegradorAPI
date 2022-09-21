//
//  AndesModalCustomViewBuilder.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 26/05/22.
//

import UIKit

/// Provide constructor for andes modal with custom view
@objc
public class AndesCustomModalBuilder: NSObject {
    private let options = AndeModalCustomViewOptions()
    private var buttons: [AndesButton] = []
    private var distribution: AndesButtonGroupDistribution = .vertical
    private weak var delegate: AndesModalDelegate?

    @objc
    public init(type: AndesModalType) {
        options.type = type
    }

    @objc
    @discardableResult
    public func dismissable(_ dissmis: Bool) -> Self {
        options.allowsCloseButton = dissmis
        return self
    }

    @discardableResult
    public func withActions(_ buttons: AndesButton..., distribution: AndesButtonGroupDistribution = .vertical) -> Self {
        withActions(buttons, distribution: distribution)
    }

    @objc
    @discardableResult
    public func withActions(_ buttons: [AndesButton], distribution: AndesButtonGroupDistribution = .vertical) -> Self {
        self.buttons = buttons
        self.distribution = distribution
        return self
    }

    @objc
    @discardableResult
    public func withoutActions() -> Self {
        self.buttons = []
        return self
    }

    @objc
    @discardableResult
    public func content(size: AndesModalCustomViewSize = .maxHeight, _ view: UIView) -> Self {
        options.customView = view
        options.contentSize = size
        return self
    }

    @objc
    @discardableResult
    public func ignoreHorizontalMargins(_ ignore: Bool) -> Self {
        options.ignoreHorizontalMargins = ignore
        return self
    }

    @objc
    @discardableResult
    public func delegate(_ delegate: AndesModalDelegate) -> Self {
        self.delegate = delegate
        return self
    }

    @objc
    public func build() -> AndesModal {
        guard let customView = options.customView else {
            preconditionFailure("custom view is needed")
        }

        if options.type == .card {
            /// for modal card, it is always calculated in size based on customView
            options.contentSize = .intrinsic
        }

        if options.contentSize == .intrinsic {
            let height = customView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            guard height > 0 else {
                preconditionFailure("can not determine height of your view, needs a intrinsic content size or height constraint")
            }
        }

        let actions = AndesModalActions(
            buttons: buttons,
            distribution: distribution
        )
        let container = AndesModalContainer(for: options, with: actions)
        container.delegate = delegate
        return container
    }
}
