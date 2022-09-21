//
//  AndesMessageWithThumbnailAndActionsView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-03-21.
//

import Foundation

class AndesMessageWithThumbnailAndActionsView: AndesMessageWithActionsView {
    @IBOutlet var thumbnail: AndesThumbnail!

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesMessageWithThumbnailAndActionsView", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
        guard let thumbnail = config.thumbnail else { return }
        self.thumbnail.image = thumbnail
    }
}
