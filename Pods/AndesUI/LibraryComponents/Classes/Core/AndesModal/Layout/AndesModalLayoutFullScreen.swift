//
//  AndesModalLayoutFullScreen.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//

import UIKit

internal struct AndesModalLayoutFullScreen: AndesModalLayoutProtocol {
    var titleSize = AndesLabelTitleSize.titleM
    var bodySize = AndesLabelBodySize.bodyM
    var margins = UIEdgeInsets(top: 20, left: 22, bottom: 20, right: 22)
    var imageMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
    var footerMargins = UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    var cornerRadius = CGFloat.zero
    var backgroundColor = UIColor.Andes.white
    var titleTopMargin: CGFloat = 26

    init(options: AndesModalOptions) {
        imageMargins.top = options.isFixedTitleEnabled && options.imageStyle != .none ? 64 : 0
        if options.imageStyle == .none {
            titleTopMargin = 24
        }
    }
}
