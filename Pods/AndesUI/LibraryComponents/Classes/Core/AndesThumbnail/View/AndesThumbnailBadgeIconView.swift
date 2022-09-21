//
//  AndesThumbnailBadgeIconView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 23/08/21.
//

class AndesThumbnailBadgeIconView: AndesThumbnailIconView, AndesThumbnailBadgeableView {
    var badgeView: UIView!

    override func drawImage() {
        super.drawImage()
        setupOutline()
        setupBadge()
    }
}
