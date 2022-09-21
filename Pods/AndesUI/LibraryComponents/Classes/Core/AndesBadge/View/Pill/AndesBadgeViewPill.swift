//
//  AndesBadgeViewPill.swift
//  AndesUI
//

import Foundation

class AndesBadgeViewPill: AndesBadgeAbstractView {
    @IBOutlet var textLabel: UILabel!

    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var widthConstraint: NSLayoutConstraint!

    @IBOutlet var left: NSLayoutConstraint!
    @IBOutlet var top: NSLayoutConstraint!
    @IBOutlet var bottom: NSLayoutConstraint!
    @IBOutlet var right: NSLayoutConstraint!

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesBadgeViewPill", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()

        textLabel.setAndesStyle(style: config.textStyle!)
        textLabel.text = config.text
        textLabel.textAlignment = .center

        heightConstraint.constant = config.height!
        widthConstraint.constant = config.height!
        left.constant = config.horizontalPadding!
        right.constant = config.horizontalPadding!
        bottom.constant = config.verticalPadding!
        top.constant = config.verticalPadding!

        let cornerRadius = config.cornerRadius
        let roundedCorners = config.roundedCorners

        self.setCornerRadius(cornerRadius: cornerRadius, roundedCorners: roundedCorners)
    }
}
