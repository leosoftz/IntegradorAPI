//
//  AndesCardWidthLinkView.swift
//  AndesUI
//
//  Created by Martin Victory on 15/07/2020.
//

import UIKit

class AndesCardWithLinkView: AndesCardAbstractView {
    // MARK: - Xib Outlets
    @IBOutlet var linkContainer: UIView!
    @IBOutlet var linkLbl: UILabel!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var linkLineDivider: UIView!

    @IBOutlet var linkContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet var linkLblLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var iconViewTrailingConstraint: NSLayoutConstraint!

    // MARK: - Initialization
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesCardWithLinkView", owner: self, options: nil)
    }

    override func setup() {
        super.setup()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        linkContainer.addGestureRecognizer(tapGesture)

        linkLbl.setAndesStyle(style: AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.accentColor500, font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 16), lineSpacing: 1))

        AndesIconsProvider.loadIcon(name: AndesIcons.chevronRight20, placeItInto: iconView)
        iconView.tintColor = AndesStyleSheetManager.styleSheet.accentColor500

        linkLineDivider.backgroundColor = UIColor.Andes.gray100
    }

    // MARK: - Update View
    override func updateView() {
        super.updateView()
        updateLink()
    }

    private func updateLink() {
        linkLbl.text = config.linkText
        linkContainerHeightConstraint.constant = CGFloat(config.titleHeight)
        linkLblLeadingConstraint.constant = CGFloat(config.titlePadding)
        iconViewTrailingConstraint.constant = CGFloat(config.titlePadding)
    }

    // MARK: - User Interaction
    @objc internal func handleTap() {
        self.delegate?.onLinkTouchUp()
    }
}
