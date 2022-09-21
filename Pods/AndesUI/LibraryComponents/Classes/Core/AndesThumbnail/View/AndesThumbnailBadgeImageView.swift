//
//  AndesThumbnailBadgeImageView.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 19/08/21.
//

class AndesThumbnailBadgeImageView: AndesThumbnailImageView, AndesThumbnailBadgeableView {
    var badgeView: UIView!

    override func drawImage() {
        super.drawImage()
        setupOutline()
        setupBadge()
    }
}
