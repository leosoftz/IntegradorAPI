//
//
//  AndesModalViewDefault.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 4/05/22.
//
//

import UIKit

class AndesModalCardView: UIView, AndesModalView {
    private let animator = AndesModalCardAnimator()
    private let contentView: AndesModalBodyView
    private let config: AndesModalViewConfig

    weak var delegate: AndesModalViewDelegate?
    var preferredStatusBarStyle: UIStatusBarStyle = .default

    private let dismissButton = AndesModalCloseButton()

    init(with config: AndesModalViewConfig) {
        dismissButton.isHidden = !config.options.allowsCloseButton

        // The card has the closing button on the outside of the body.
        config.options.allowsCloseButton = false
        self.config = config
        self.contentView = AndesModalBodyView(config: config)
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

        if let source = config.options.pages.first {
            contentView.source = source
        }
        contentView.bodyDelegate = self
        contentView.showTitleShadownOnStartScrolling = false
        contentView.backgroundColor = UIColor.Andes.white
        contentView.closeButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)
        contentView.updateLayout()

        addSubview(contentView)
        addSubview(dismissButton)

        dismissButton.tintColor = UIColor.Andes.white
        dismissButton.alignRight()
        dismissButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)

        contentView.autoPinEdge(toSuperviewEdge: .leading, withInset: config.layout.margins.left, relation: .equal)
        contentView.autoPinEdge(toSuperviewEdge: .trailing, withInset: config.layout.margins.left, relation: .equal)
        contentView.autoAlignAxis(toSuperviewAxis: .horizontal).priority = .defaultLow
        dismissButton.autoPinEdge(.trailing, to: .trailing, of: contentView)
        dismissButton.autoPinEdge(.bottom, to: .top, of: contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(greaterThanOrEqualTo: layoutMarginsGuide.topAnchor, constant: AndesModalCloseButton.buttonSize),
            contentView.bottomAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.bottomAnchor, constant: -AndesModalCloseButton.buttonSize)
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
            containerView: contentView,
            dismissButton: dismissButton
        ) { [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }

    func animateAppear() {
        animator.animateAppear(
            view: self,
            containerView: contentView,
            dismissButton: dismissButton
        )
    }
}

extension AndesModalCardView: AndesModalBodyViewDelegate {
    func modalBody(_ body: AndesModalBodyView, didTouchLink index: Int, at label: AndesLabelType) {
        self.delegate?.andesModalView(self, didTouchLink: index, at: label, of: 0)
    }
}
