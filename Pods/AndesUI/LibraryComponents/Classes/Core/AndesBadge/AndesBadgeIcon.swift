//
//  AndesBadgeIcon.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 17/08/21.
//

import Foundation

@objc public class AndesBadgeIcon: UIView {
    internal var contentView: AndesBadgeView!

    /// Defines the colors/icon of the Badge
    @objc public var iconType: AndesBadgeIconType = .green {
        didSet {
            updateContentView()
        }
    }

    /// Defines the size of the AndesBadge
    @objc public var size: AndesBadgeSize = .large {
        didSet {
            updateContentView()
        }
    }

    /// Defines the hierarchy of the AndesBadge
    @objc public var hierarchy: AndesBadgeIconHierarchy = .loud {
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

    @objc public init(iconType: AndesBadgeIconType, hierarchy: AndesBadgeIconHierarchy, size: AndesBadgeSize) {
        super.init(frame: .zero)
        self.iconType = iconType
        self.size = size
        self.hierarchy = hierarchy
        setup()
    }

    @objc public init(iconType: AndesBadgeIconType, size: AndesBadgeSize) {
        super.init(frame: .zero)
        self.iconType = iconType
        self.size = size
        self.hierarchy = .loud
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesBadgeView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func updateContentView() {
        contentView.isAccessibilityElement = false

        let config = AndesBadgeViewConfigFactory.provideInternalConfig(fromIcon: self)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which Badge modifier is selected
    private func provideView() -> AndesBadgeView {
        let config = AndesBadgeViewConfigFactory.provideInternalConfig(fromIcon: self)
        return AndesBadgeViewIcon(withConfig: config)
    }
}

// MARK: - Interface Builder properties
public extension AndesBadgeIcon {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibIconType: String {
        set(val) {
            self.iconType = AndesBadgeIconType.checkValidEnum(property: "IB Type", key: val)
        }
        get {
            return self.iconType.toString()
        }
    }

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'size' instead.")
    @IBInspectable var ibSize: String {
        set(val) {
            self.size = AndesBadgeSize.checkValidEnum(property: "IB Size", key: val)
        }
        get {
            return self.size.toString()
        }
    }
}
