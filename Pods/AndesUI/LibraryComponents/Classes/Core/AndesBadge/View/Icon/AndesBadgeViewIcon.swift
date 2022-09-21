//
//  AndesBadgeViewIcon.swift
//  AndesUI
//
//  Created by Ana Cristina Calderon Castrillon on 17/08/21.
//

import UIKit

class AndesBadgeViewIcon: AndesBadgeAbstractView {
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesBadgeViewIcon", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()

        AndesIconsProvider.loadIcon(name: config.icon ?? "", success: { image in
            iconView.image = image.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = UIColor.white
        })

        heightConstraint.constant = config.height ?? 0
        self.backgroundColor = UIColor.clear

        iconView.backgroundColor = config.backgroundColor
        let cornerRadius = config.cornerRadius
        let roundedCorners = config.roundedCorners
        iconView.setCornerRadius(cornerRadius: cornerRadius, roundedCorners: roundedCorners)
    }
}
