//
//  AndesModalFullCustomView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 26/05/22.
//

import UIKit

class AndesModalFullCustomView: UIView, AndesModalView {
    private let animator = AndesModalFullAnimator()
    private let scrollView = UIScrollView()
    private let titleView = AndesModalTitleView()
    private let customView: UIView

    var preferredStatusBarStyle: UIStatusBarStyle = .default
    let config: AndesModalViewConfig
    weak var delegate: AndesModalViewDelegate?

    init(for view: UIView, with config: AndesModalViewConfig) {
        self.config = config
        self.customView = view
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("not supported")
    }

    func setup() {
        layoutMargins = .zero
        backgroundColor = config.layout.backgroundColor

        scrollView.delegate = self
        scrollView.layoutMargins = config.layout.margins

        titleView.title = ""
        titleView.preservesSuperviewLayoutMargins = true
        titleView.closeButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)

        setupConstraints()
    }

    func setupConstraints() {
        addSubview(scrollView)
        scrollView.autoMatch(.width, to: .width, of: self)
        scrollView.autoPinEdgesToSuperviewMargins()

        scrollView.addSubview(customView)

        if config.options.ignoreHorizontalMargins {
            customView.autoMatch(.width, to: .width, of: self)
            customView.autoPinEdge(toSuperviewEdge: .leading)
            customView.autoPinEdge(toSuperviewEdge: .trailing)
        } else {
            customView.autoMatch(.width, to: .width, of: self, withOffset: -config.layout.margins.horizontally)
            customView.autoPinEdge(toSuperviewMargin: .leading)
            customView.autoPinEdge(toSuperviewMargin: .trailing)
        }

        if config.options.allowsCloseButton {
            scrollView.addSubview(titleView)
            titleView.autoMatch(.width, to: .width, of: self)
            titleView.autoSetDimension(.height, toSize: titleView.kHeight)
            titleView.autoPinEdge(toSuperviewEdge: .leading)
            titleView.autoPinEdge(toSuperviewEdge: .trailing)
            titleView.topAnchor.constraint(equalTo: scrollView.topFixedAnchor).isActive = true

            customView.autoPinEdge(toSuperviewEdge: .top, withInset: titleView.kHeight)
        } else {
            customView.autoPinEdge(toSuperviewMargin: .top)
        }

        if let footer = config.footerView {
            let footerContainer = UIView()
            let footerHeight = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            let height = footerHeight + config.layout.footerMargins.vertically

            footerContainer.preservesSuperviewLayoutMargins = true
            footerContainer.translatesAutoresizingMaskIntoConstraints = false
            footerContainer.layoutMargins.bottom = config.layout.footerMargins.bottom
            footerContainer.layoutMargins.top = config.layout.footerMargins.top
            scrollView.addSubview(footerContainer)

            footerContainer.backgroundColor = UIColor.Andes.white
            footerContainer.autoPinEdge(toSuperviewEdge: .leading)
            footerContainer.autoPinEdge(toSuperviewEdge: .trailing)
            footerContainer.bottomAnchor.constraint(equalTo: scrollView.bottomFixedAnchor).isActive = true

            footer.translatesAutoresizingMaskIntoConstraints = false
            footerContainer.addSubview(footer)
            footer.autoPinEdgesToSuperviewMargins()

            switch config.options.contentSize {
            case .intrinsic:
                customView.autoPinEdge(toSuperviewEdge: .bottom, withInset: height)
            case .maxHeight:
                customView.bottomAnchor.constraint(equalTo: scrollView.bottomFixedAnchor, constant: -height).isActive = true
            }
        } else {
            switch config.options.contentSize {
            case .intrinsic:
                customView.autoPinEdge(toSuperviewEdge: .bottom)
            case .maxHeight:
                customView.bottomAnchor.constraint(equalTo: scrollView.bottomFixedAnchor).isActive = true
            }
        }
    }

    @IBAction private func didTouchDissmisButton() {
        animateDisappear()
    }

    override func accessibilityPerformEscape() -> Bool {
        animateDisappear()
        return true
    }

    // MARK: - Modal View
    func animateAppear() {
        animator.animateAppear(view: self, dismissButton: titleView.closeButton)
    }

    func animateDisappear() {
        animator.animateDisappear(view: self, dismissButton: titleView.closeButton) { [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }
}

extension AndesModalFullCustomView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            titleView.showShadow()
        } else {
            titleView.hideShadow()
        }
    }
}
