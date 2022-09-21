//
//  AndesModalBodyView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit
import PureLayout

protocol AndesModalBodyViewDelegate: AnyObject {
    func modalBody(_ body: AndesModalBodyView, didTouchLink index: Int, at label: AndesLabelType)
}

internal class AndesModalBodyView: UIScrollView, AndesAccessibleView {
    internal let fixedTitleView = AndesModalTitleView()
    internal let imageContainer = AndesModalImageView()
    internal let titleView = AndesModalTitleView()
    internal let bodyLabel = AndesLabel()
    internal let config: AndesModalViewConfig
    private let footerContainer = UIView()
    private var contentHeight: CGFloat = 0.0

    private var distribution: AndesModalVerticalAlignment { config.verticalAlignmet }
    private var imageStyle: AndesModalImageStyle { config.options.imageStyle }
    private var allowsCloseButton: Bool { config.options.allowsCloseButton }
    private var isFixedTitleEnabled: Bool { config.options.isFixedTitleEnabled }
    private var isFixedFooterEnabled: Bool { config.options.isFixedFooterEnabled }
    internal var closeButton: UIButton { titleView.closeButton }
    internal var fixedCloseButton: UIButton { fixedTitleView.closeButton }

    internal var showTitleShadownOnStartScrolling = true

    /// When title is not fixed, but the contents is small, the close button should be located at top
    private var fixedTitleBottonSpacing: NSLayoutConstraint?

    internal weak var bodyDelegate: AndesModalBodyViewDelegate?
    internal var accessibilityManager: AndesAccessibilityManager?

    var source: AndesModalContent? {
        didSet {
            guard let source = source else {
                return
            }
            imageContainer.imageView.contentMode = config.imageContentMode
            imageContainer.imageView.backgroundColor = source.image == nil ? UIColor.Andes.gray100 : .clear
            source.image?.setImage(in: imageContainer.imageView)

            source.title
                .with(type: .title, size: config.layout.titleSize)
                .apply(to: titleView.titleLabel) { [weak self] index in
                    guard let self = self else { return }
                    self.bodyDelegate?.modalBody(self, didTouchLink: index, at: .title)
                }

            if let body = source.body {
                body
                    .with(type: .body, size: config.layout.bodySize)
                    .apply(to: bodyLabel) { [weak self] index in
                        guard let self = self else { return }
                        self.bodyDelegate?.modalBody(self, didTouchLink: index, at: .body)
                    }
            } else {
                bodyLabel.text = nil
            }

            fixedTitleView.titleLabel.font = titleView.titleLabel.font
            accessibilityManager?.viewUpdated()
        }
    }

    init(config: AndesModalViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable, message: "not supported")
    required init?(coder: NSCoder) {
        preconditionFailure()
    }

    private func setup() {
        bounces = false
        clipsToBounds = true
        delegate = self
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = config.layout.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = config.layout.margins

        titleView.textAlignment = config.textAlignment
        bodyLabel.textAlignment = config.textAlignment
        bodyLabel.textColor = .black

        imageContainer.imageStyle = config.options.imageStyle
        imageContainer.layoutMargins = config.layout.imageMargins
        footerContainer.layoutMargins = config.layout.footerMargins

        fixedTitleView.textAlignment = config.textAlignment
        fixedTitleView.preservesSuperviewLayoutMargins = true
        fixedTitleView.backgroundColor = .clear
        fixedTitleView.closeButton.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)

        titleView.alignment = .top
        titleView.numberOfLines = 0
        let iconsSize = AndesModalCloseButton.iconSize / 2
        titleView.closeButton.transform = .init(translationX: iconsSize, y: -iconsSize)
        if config.options.imageStyle == .none && config.options.type == .fullscreen {
            titleView.titleLabel.transform = .init(translationX: 0, y: -iconsSize / 2)
        }
        bodyLabel.numberOfLines = 0

        footerContainer.backgroundColor = UIColor.Andes.white

        [imageContainer, bodyLabel, titleView, fixedTitleView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }

        accessibilityManager = AndesModalBodyViewAccesibilityManager(view: self)
    }

    @objc
    private func didTouchCloseButton() {
        titleView.closeButton.sendActions(for: .touchUpInside)
    }

    internal func updateLayout() {
        [imageContainer, bodyLabel, titleView, fixedTitleView, footerContainer].compactMap { $0 }.forEach { view in
            view.removeFromSuperview()
            self.addSubview(view)
        }

        setupCloseButton()
        setupHeaderConstratints()

        let titleTopMargin = imageStyle == .none && isFixedTitleEnabled ? fixedTitleView.closeButtonFirstBaseLine : config.layout.titleTopMargin

        NSLayoutConstraint.activate([
            fixedTitleView.widthAnchor.constraint(equalTo: widthAnchor),
            imageContainer.widthAnchor.constraint(equalTo: widthAnchor),

            titleView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: titleTopMargin),

            bodyLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            bodyLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor)
        ])

        if source?.body == nil {
            bodyLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor)
                .isActive = true
        } else {
            bodyLabel.topAnchor.constraint(equalTo: titleView.titleLastBaselineAnchor, constant: config.layout.titleTopMargin)
                .isActive = true
        }

        setupFooterConstraints()
    }

    private func setupCloseButton() {
        guard allowsCloseButton else {
            // `card`: the close button is always on the outside of the card.
            fixedTitleView.isHidden = !isFixedTitleEnabled
            fixedTitleView.hideCloseButton()
            titleView.hideCloseButton()
            return
        }

        titleView.hideCloseButton()
        if case .none = imageStyle, isFixedTitleEnabled {
            titleView.reserveCloseButtonSpace()
        }

        if case .none = imageStyle, !isFixedTitleEnabled {
            fixedTitleView.isHidden = true
            titleView.showCloseButton()
        }
    }

    private func setupHeaderConstratints() {
        if isFixedTitleEnabled {
            NSLayoutConstraint.activate([
                fixedTitleView.heightAnchor.constraint(equalToConstant: fixedTitleView.kHeight),
                fixedTitleView.topAnchor.constraint(equalTo: topFixedAnchor),
                imageContainer.topAnchor.constraint(equalTo: topAnchor)
            ])
        } else {
            let titleHeight = imageStyle == .none ? 0 : fixedTitleView.kHeight
            let imageSpacing = config.options.allowsCloseButton ? titleHeight : 0
            fixedTitleView.heightAnchor.constraint(equalToConstant: titleHeight).isActive = true
            imageContainer.topAnchor.constraint(equalTo: topAnchor, constant: imageSpacing).isActive = true

            let fixedBottom = fixedTitleView.bottomAnchor.constraint(greaterThanOrEqualTo: imageContainer.topAnchor)
            fixedBottom.priority = .required
            fixedBottom.isActive = true
            self.fixedTitleBottonSpacing = fixedBottom
        }
    }

    private func setupFooterConstraints() {
        guard let footer = config.footerView else {
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -layoutMargins.bottom).isActive = true
            return
        }

        footerContainer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.addSubview(footer)

        let height = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        footerContainer.bringSubviewToFront(bodyLabel)
        footerContainer.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor).isActive = true
        footer.autoPinEdgesToSuperviewMargins()

        NSLayoutConstraint.activate([
            footerContainer.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            footerContainer.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            footerContainer.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor)
        ])

        contentInset.bottom = height + footerContainer.layoutMargins.vertically
        if isFixedFooterEnabled {
            NSLayoutConstraint.activate([
                bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                footerContainer.bottomAnchor.constraint(equalTo: bottomFixedAnchor)
            ])
        } else {
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            let footerTop = footerContainer.topAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor)
            footerTop.priority = .required
            footerTop.isActive = true

            let footerBottom = footerContainer.bottomAnchor.constraint(equalTo: bottomFixedAnchor)
            footerBottom.priority = .defaultLow
            footerBottom.isActive = true
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        contentHeight = contentSize.height
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }

        if case .middle = distribution {
            if contentHeight < bounds.size.height {
                contentInset.top = (bounds.size.height - contentHeight - footerContainer.bounds.height) / 2
                fixedTitleBottonSpacing?.constant = -contentInset.top
            }
        }

        // `Banner` has to reach to the edge
        //  override any value that they set externally
        layoutMargins.top = 0
    }

    override public var intrinsicContentSize: CGSize {
        // The content will try to use as much space as possible before starting to scroll.
        return CGSize(width: contentSize.width, height: contentHeight + contentInset.vertically)
    }
}

extension AndesModalBodyView: UIScrollViewDelegate {
    private func fixedHeaderIfNeeded() {
        guard isFixedTitleEnabled else {
            return
        }

        if showTitleShadownOnStartScrolling {
            let posY = contentOffset.y
            if posY + contentInset.top > 1 {
                fixedTitleView.title = ""
                fixedTitleView.showShadow()
            } else {
                fixedTitleView.hideShadow()
            }
        }

        let titleY = convert(titleView.frame, to: fixedTitleView).maxY
        if titleY < fixedTitleView.frame.minY {
            fixedTitleView.showTitle(titleView.title)
            if !showTitleShadownOnStartScrolling {
                fixedTitleView.showShadow()
            }
        } else {
            fixedTitleView.hideTitle()
            if !showTitleShadownOnStartScrolling {
                fixedTitleView.hideShadow()
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        fixedHeaderIfNeeded()
    }
}
