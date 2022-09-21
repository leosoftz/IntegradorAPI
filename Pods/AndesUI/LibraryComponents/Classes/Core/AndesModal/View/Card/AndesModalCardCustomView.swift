//
//  AndesModalCardCustomView.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 31/05/22.
//

import UIKit
import PureLayout

class AndesModalCardCustomView: UIView, AndesModalView {
    var preferredStatusBarStyle: UIStatusBarStyle = .default
    weak var delegate: AndesModalViewDelegate?

    private let animator = AndesModalCardAnimator()
    private let config: AndesModalViewConfig
    private let containerView = UIScrollView()
    private let customView: UIView

    private let dismissButton = AndesModalCloseButton()

    init(for view: UIView, with config: AndesModalViewConfig) {
        dismissButton.isHidden = !config.options.allowsCloseButton
        config.options.allowsCloseButton = false
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
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = config.layout.backgroundColor

        preferredStatusBarStyle = .lightContent

        dismissButton.tintColor = UIColor.Andes.white
        dismissButton.alignRight()
        dismissButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)

        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = config.layout.cornerRadius
        containerView.backgroundColor = UIColor.Andes.white
        containerView.layoutMargins = config.layout.margins
        containerView.layoutMargins.top = config.layout.margins.bottom

        addSubview(dismissButton)
        setupConstraints(to: containerView)
    }

    func container(for footer: UIView) -> UIView {
        let footerContainer = UIView(forAutoLayout: ())
        footerContainer.backgroundColor = UIColor.Andes.white
        footerContainer.layoutMargins = config.layout.margins
        footerContainer.layoutMargins.bottom = config.layout.footerMargins.bottom
        footerContainer.layoutMargins.top = config.layout.footerMargins.top

        footer.translatesAutoresizingMaskIntoConstraints = false
        footerContainer.addSubview(footer)
        footer.autoPinEdgesToSuperviewMargins()
        return footerContainer
    }

    func setupConstraints(to containerView: UIScrollView) {
        containerView.addSubview(customView)
        addSubview(containerView)
        customView.autoPinEdge(toSuperviewMargin: .top)

        if config.options.ignoreHorizontalMargins {
            customView.autoMatch(.width, to: .width, of: containerView)
            customView.autoPinEdge(toSuperviewEdge: .leading)
            customView.autoPinEdge(toSuperviewEdge: .trailing)
        } else {
            customView.autoPinEdge(toSuperviewMargin: .leading)
            customView.autoPinEdge(toSuperviewMargin: .trailing)
            customView.autoMatch(.width, to: .width, of: containerView, withOffset: -config.layout.margins.horizontally)
        }

        if let footer = config.footerView {
            let footerContainer = container(for: footer)
            let footerSize = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            let footerHeight = footerSize.height + config.layout.footerMargins.vertically

            containerView.addSubview(footerContainer)
            footerContainer.autoMatch(.width, to: .width, of: containerView)
            footerContainer.autoPinEdge(toSuperviewEdge: .leading)
            footerContainer.autoPinEdge(toSuperviewEdge: .trailing)
            footerContainer.bottomAnchor.constraint(equalTo: containerView.bottomFixedAnchor).isActive = true

            customView.autoPinEdge(toSuperviewEdge: .bottom, withInset: footerHeight)
            containerView.autoMatch(.height, to: .height, of: customView, withOffset: containerView.layoutMargins.top + footerHeight)
                .priority = .defaultHigh
        } else {
            customView.autoPinEdge(toSuperviewMargin: .bottom)
            containerView.autoMatch(.height, to: .height, of: customView, withOffset: containerView.layoutMargins.vertically, relation: .equal)
                .priority = .defaultHigh
        }

        dismissButton.autoPinEdge(.trailing, to: .trailing, of: containerView)
        dismissButton.autoPinEdge(.bottom, to: .top, of: containerView)

        containerView.autoPinEdge(toSuperviewEdge: .leading, withInset: config.layout.margins.left, relation: .equal)
        containerView.autoPinEdge(toSuperviewEdge: .trailing, withInset: config.layout.margins.left, relation: .equal)
        containerView.autoAlignAxis(toSuperviewAxis: .horizontal).priority = .defaultLow

        let buttonSize = AndesModalCloseButton.buttonSize
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: buttonSize),
            containerView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -buttonSize)
        ])
    }

    @IBAction private func didTouchDissmisButton() {
        animateDisappear()
    }

    override func accessibilityPerformEscape() -> Bool {
        animateDisappear()
        return true
    }

    // MARK: - Modal View
    func animateDisappear() {
        animator.animateDisappear(
            view: self,
            containerView: containerView,
            dismissButton: dismissButton
        ) { [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }

    func animateAppear() {
        animator.animateAppear(
            view: self,
            containerView: containerView,
            dismissButton: dismissButton
        )
    }
}
