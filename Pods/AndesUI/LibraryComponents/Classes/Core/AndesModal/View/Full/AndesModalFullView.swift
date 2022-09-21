//
//  AndesModalFullView.swift
//  AndesUI
//
//  Created by Carlos Chaguendo on 6/05/22.
//  Copyright © 2022 Mercado Libre. All rights reserved.
//

import UIKit
import PureLayout

class AndesModalFullView: UIView, AndesModalView {
    private let animator = AndesModalFullAnimator()
    private let contentView: AndesModalBodyView
    private let config: AndesModalViewConfig

    var preferredStatusBarStyle: UIStatusBarStyle = .default
    weak var delegate: AndesModalViewDelegate?

    init(with config: AndesModalViewConfig) {
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
        backgroundColor = config.layout.backgroundColor

        if let source = config.options.pages.first {
            contentView.source = source
        }

        contentView.bodyDelegate = self
        contentView.closeButton.addTarget(self, action: #selector(didTouchDissmisButton), for: .touchUpInside)
        addSubview(contentView)
        contentView.autoPinEdgesToSuperviewMargins()
        contentView.updateLayout()
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
        animator.animateAppear(view: self, dismissButton: contentView.fixedCloseButton)
    }

    func animateDisappear() {
        animator.animateDisappear(view: self, dismissButton: contentView.fixedCloseButton) { [weak self] in
            guard let self = self else { return }
            self.delegate?.andesModalViewDidDissmis(self)
        }
    }
}

extension AndesModalFullView: AndesModalBodyViewDelegate {
    func modalBody(_ body: AndesModalBodyView, didTouchLink index: Int, at label: AndesLabelType) {
        self.delegate?.andesModalView(self, didTouchLink: index, at: label, of: 0)
    }
}
