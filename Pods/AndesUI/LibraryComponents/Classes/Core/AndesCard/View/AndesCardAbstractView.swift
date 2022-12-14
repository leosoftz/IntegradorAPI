//
//  AndesCardAbstractView.swift
//  AndesUI
//
//  Created by Martin Victory on 14/07/2020.
//

import UIKit

class AndesCardAbstractView: UIView, AndesCardView {
    weak var delegate: AndesCardViewDelegate?

    // MARK: - Xib Outlets

    @IBOutlet var containerView: UIView!
    @IBOutlet var leftPipe: UIView!
    @IBOutlet var userViewContainer: UIView!
    @IBOutlet var titleContainer: UIView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var titleLineDivider: UIView!

    @IBOutlet var topUserViewContainerConstraint: NSLayoutConstraint!
    @IBOutlet var leadingUserViewContainerConstraint: NSLayoutConstraint!
    @IBOutlet var trailingUserViewContainerConstraint: NSLayoutConstraint!
    @IBOutlet var bottomUserViewContainerConstraint: NSLayoutConstraint!
    @IBOutlet var titleContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var titleLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var titleLblTrailingConstraint: NSLayoutConstraint!

    // MARK: - View initialization

    internal var config: AndesCardViewConfig
    private weak var userCardView: UIView?
    private var cardTapGestureRecongizer: UIGestureRecognizer?

    init(withConfig config: AndesCardViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        self.config = AndesCardViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        setupCardAction()

        self.addSubview(containerView)
        containerView.pinToSuperview()
        containerView.layer.cornerRadius = 6
        containerView.clipsToBounds = true

        userViewContainer.backgroundColor = .clear
        titleLbl.setAndesStyle(style: AndesFontStyle(textColor: UIColor.Andes.graySolid800, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 16), lineSpacing: 1))
        titleLineDivider.backgroundColor = UIColor.Andes.gray100

        updateView()
    }

    /// Override this method on each Card View to setup its unique Xib
    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    private func setupCardAction() {
        self.cardTapGestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(onCardTouchUp))
    }

    @objc internal func onCardTouchUp() {
        delegate?.onCardTouchUp()
    }

    // MARK: - View configuration

    /// Override this method on each Card View to setup its unique components
    internal func updateView() {
        containerView.backgroundColor = config.backgroundColor
        leftPipe.backgroundColor = config.pipeColor

        updateUserView()
        updatePadding()
        updateBorder()
        updateShadow()
        updateTitle()
        updateCardAction()
    }

    private func updateUserView() {
        userCardView?.removeFromSuperview()
        userViewContainer.addSubview(config.cardView)
        config.cardView.pinToSuperview()

        userCardView = config.cardView
    }

    private func updatePadding() {
        topUserViewContainerConstraint.constant = CGFloat(config.bodyPadding)
        leadingUserViewContainerConstraint.constant = CGFloat(config.bodyPadding)
        trailingUserViewContainerConstraint.constant = CGFloat(config.bodyPadding)
        bottomUserViewContainerConstraint.constant = CGFloat(config.bodyPadding)
    }

    private func updateBorder() {
        if let borderColor = config.borderColor {
            containerView.layer.borderColor = borderColor.cgColor
            containerView.layer.borderWidth = 1
        } else {
            containerView.layer.borderWidth = 0
        }
    }

    private func updateShadow() {
        if let shadowConfig = config.shadow {
            layer.shadowColor = shadowConfig.shadowColor.cgColor
            layer.shadowOffset = shadowConfig.shadowOffset
            layer.shadowOpacity = shadowConfig.shadowOpacity
            layer.shadowRadius = shadowConfig.shadowRadius
        } else {
            layer.shadowColor = UIColor.clear.cgColor
        }
    }

    private func updateTitle() {
        guard let titleText = config.titleText else {
            titleLbl.isHidden = true
            titleContainerHeightConstraint.constant = 0
            return
        }

        titleLbl.isHidden = false
        titleLbl.text = titleText
        titleContainerHeightConstraint.constant = CGFloat(config.titleHeight)
        titleLblLeadingConstraint.constant = CGFloat(config.titlePadding)
        titleLblTrailingConstraint.constant = CGFloat(config.titlePadding)
    }

    private func updateCardAction() {
        guard let gestureRecognizer = self.cardTapGestureRecongizer else {
            return
        }

        if config.hasCardAction {
            self.addGestureRecognizer(gestureRecognizer)
            self.userViewContainer.isUserInteractionEnabled = false
        } else {
            self.removeGestureRecognizer(gestureRecognizer)
            self.userViewContainer.isUserInteractionEnabled = true
        }
    }

    func update(withConfig config: AndesCardViewConfig) {
        self.config = config
        updateView()
    }
}
