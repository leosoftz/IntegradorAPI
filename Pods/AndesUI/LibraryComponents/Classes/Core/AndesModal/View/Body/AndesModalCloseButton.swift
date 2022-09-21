//
//  AndesModalCloseButton.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 7/06/22.
//

import UIKit
import PureLayout

internal class AndesModalCloseButton: UIButton, AndesAccessibleView {
    internal static let iconSize: CGFloat = 24
    internal static let buttonSize: CGFloat = 48
    internal static let translationX: CGFloat = 14
    internal var accessibilityManager: AndesAccessibilityManager?

    init() {
        super.init(frame: .zero)
        setTitle(nil, for: .normal)
        setTitleColor(.black, for: .normal)
        AndesIconsProvider.loadIcon(name: AndesIcons.close24) {
            self.setImage($0, for: .normal)
        }

        autoSetDimension(.width, toSize: AndesModalCloseButton.buttonSize)
        autoSetDimension(.height, toSize: AndesModalCloseButton.buttonSize)
        accessibilityManager = AndesModalCloseButtonAccesibilityManager(view: self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func alignRight() {
        self.transform = .init(translationX: AndesModalCloseButton.translationX, y: 0)
    }
}
