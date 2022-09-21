//
//  AndesModalBuilder.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 18/05/22.
//

import Foundation

/// Provide constructor for andes modal
@objc
public class AndesModalBuilder: NSObject {
    private let options = AndesModalOptions()
    private var buttons: [AndesButton] = []
    private var distribution: AndesButtonGroupDistribution = .vertical
    private weak var delegate: AndesModalDelegate?

    @objc
    public init(type: AndesModalType) {
        options.type = type
    }

    @objc
    @discardableResult
    public func fixedTitle(_ fixed: Bool) -> Self {
        options.isFixedTitleEnabled = fixed
        return self
    }

    @objc
    @discardableResult
    public func fixedButtons(_ fixed: Bool) -> Self {
        options.isFixedFooterEnabled = fixed
        return self
    }

    @objc
    @discardableResult
    public func dismissable(_ dissmis: Bool) -> Self {
        options.allowsCloseButton = dissmis
        return self
    }

    @objc
    @discardableResult
    public func imageStyle(_ style: AndesModalImageStyle) -> Self {
        options.imageStyle = style
        return self
    }

    @objc
    @discardableResult
    public func delegate(_ delegate: AndesModalDelegate) -> Self {
        self.delegate = delegate
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

    @discardableResult
    public func content(_ pages: AndesModalContent...) -> Self {
        content(pages)
    }

    @objc
    @discardableResult
    public func content(_ pages: [AndesModalContent]) -> Self {
        options.pages = pages
        return self
    }

    @objc
    public func build() -> AndesModal {
        let actions = AndesModalActions(
            buttons: buttons,
            distribution: distribution
        )

        let container = AndesModalContainer(for: options, with: actions)
        container.delegate = delegate
        return container
    }
}

public extension AndesModalBuilder {
    convenience init(type: AndesModalType, @ArrayBuilder<AndesModalContent> _ makeContentArray: () -> [AndesModalContent]) {
        self.init(type: type)
        self.content(makeContentArray())
    }

    @discardableResult
    func withActions(
        _ distribution: AndesButtonGroupDistribution = .vertical,
        @ArrayBuilder<AndesButton> _ makeButtonsArray: () -> [AndesButton]
    ) -> Self {
        self.buttons = makeButtonsArray()
        self.distribution = distribution
        return self
    }
}
