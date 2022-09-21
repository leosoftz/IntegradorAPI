//
//  AndesThumbnailWithBadge.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 18/08/21.
//

import UIKit

@objc public class AndesThumbnailBadge: UIView {
    var contentView: AndesThumbnailView!

    @objc public var accessibilityDescription: String? {
        didSet {
            self.accessibilityManager?.viewUpdated()
        }
    }

    @objc public var thumbnailType: AndesThumbnailWithBadgeType = .imageCircle {
        didSet {
            self.reDrawContentViewIfNeededThenUpdate()
        }
    }

    @IBInspectable public var image: UIImage! {
        didSet {
            self.updateContentView()
        }
    }

    var badgeType: AndesThumbnailBadgeType = .dot

    var badgeText: String = ""

    var badgeColor: AndesBadgeIconType = .accent

    var hierarchy: AndesBadgeIconHierarchy = .loud

    var size: AndesThumbnailSize = .size32 {
        didSet {
            self.updateContentView()
        }
    }

    override public var contentMode: UIView.ContentMode {
        didSet {
            guard contentView != nil else { return }
            self.updateContentView()
        }
    }

    var accessibilityManager: AndesAccessibilityManager?

    @objc public init(thumbnailType: AndesThumbnailWithBadgeType, image: UIImage) {
        self.thumbnailType = thumbnailType
        self.image = image
        super.init(frame: .zero)
        setup()
        updateContentView()
    }

    init(thumbnailType: AndesThumbnailWithBadgeType, image: UIImage, color: AndesBadgeIconType, size: AndesThumbnailSize = .size64, hierarchy: AndesBadgeIconHierarchy) {
        self.thumbnailType = thumbnailType
        self.image = image
        self.badgeColor = color
        self.size = size
        self.badgeType = .hidden
        self.hierarchy = hierarchy
        super.init(frame: .zero)
        setup()
        updateContentView()
    }

    init(thumbnailType: AndesThumbnailWithBadgeType, image: UIImage, color: AndesBadgeIconType, size: AndesThumbnailSize = .size64) {
        self.thumbnailType = thumbnailType
        self.image = image
        self.badgeColor = color
        self.size = size
        self.badgeType = .hidden
        self.hierarchy = .loud
        super.init(frame: .zero)
        setup()
        updateContentView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateContentView()
    }

    @objc public func setupBadgePill(color: AndesBadgeIconType, text: String, thumbnailSize: AndesThumbnailBadgePillSize) {
        badgeType = .pill
        badgeText = text
        badgeColor = color
        size = thumbnailSize.thumbnailSizeValue
        updateContentView()
    }

    @objc public func setupBadgeDot(color: AndesBadgeIconType, thumbnailSize: AndesThumbnailBadgeDotSize) {
        badgeType = .dot
        badgeColor = color
        size = thumbnailSize.thumbnailSizeValue
        updateContentView()
    }

    @objc public func setupBadgeIconPill(color: AndesBadgeIconType, thumbnailSize: AndesThumbnailBadgePillSize) {
        badgeType = .icon
        badgeColor = color
        size = thumbnailSize.thumbnailSizeValue
        updateContentView()
    }

    private func setup() {
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        let contentView = provideContentView()
        drawContentView(with: contentView)
        accessibilityManager = AndesThumbnailBadgeAccessibilityManager(view: self)
    }

    private func drawContentView(with contentView: AndesThumbnailView) {
        self.contentView = contentView
        addSubview(contentView)
        leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

    private func provideContentView() -> AndesThumbnailView {
        let config = AndesThumbnailViewConfigFactory.provide(for: self)

        if thumbnailType == .icon {
            return AndesThumbnailBadgeIconView(config: config)
        }

        return AndesThumbnailBadgeImageView(config: config)
    }

    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideContentView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        } else {
            updateContentView()
        }
    }

    private func updateContentView() {
        let config = AndesThumbnailViewConfigFactory.provide(for: self)
        contentView.update(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesThumbnailBadge {
    @IBInspectable var ibThumbnailType: String {
        set(val) {
            self.thumbnailType = AndesThumbnailWithBadgeType.checkValidEnum(property: "IB state", key: val)
        }
        get {
            return self.thumbnailType.toString()
        }
    }
}
