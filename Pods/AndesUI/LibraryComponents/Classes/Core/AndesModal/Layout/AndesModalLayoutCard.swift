//
//  AndesModalLayoutCard.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//

import UIKit

internal struct AndesModalLayoutCard: AndesModalLayoutProtocol {
    var titleSize = AndesLabelTitleSize.titleS
    var bodySize = AndesLabelBodySize.bodyM
    var margins = UIEdgeInsets(top: 0, left: 24, bottom: 24, right: 24)
    var imageMargins = UIEdgeInsets(top: 22, left: 44, bottom: 0, right: 44)
    var footerMargins = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    var cornerRadius: CGFloat = 8.0
    var backgroundColor = UIColor.black.withAlphaComponent(0.8)
    var titleTopMargin: CGFloat = 22

    init(options: AndesModalOptions, actions: AndesModalActions) {
        if options.imageStyle == .thumbnail {
            imageMargins.left = 24
            imageMargins.right = 24
        }

        if options.imageStyle == .none {
            imageMargins.top = 2
            titleTopMargin = 12
        }

        if options.imageStyle == .banner {
            imageMargins.top = 0
        }

        if actions.buttons.isEmpty {
            margins.bottom = 28
        }

        if options.pages.count > 1 {
            // the margin is controlled outside the carousel
            margins.bottom = 0
        }
    }
}
