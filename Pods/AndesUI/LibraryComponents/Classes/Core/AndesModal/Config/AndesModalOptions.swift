//
//  AndesModalOptions.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 18/05/22.
//

import UIKit

internal class AndesModalOptions: NSObject {
    var type: AndesModalType = .card

    var isFixedTitleEnabled: Bool = true

    var isFixedFooterEnabled: Bool = true

    var allowsCloseButton = true

    var imageStyle: AndesModalImageStyle = .thumbnail

    var pages: [AndesModalContent] = []

    /// Only used for fullscren customview
    var contentSize: AndesModalCustomViewSize = .maxHeight

    /// Only used for customview
    var title: String?

    /// Only used for customview
    var ignoreHorizontalMargins = false
}

internal extension AndesModalOptions {
    var isCarousel: Bool { pages.count > 1 }
}
