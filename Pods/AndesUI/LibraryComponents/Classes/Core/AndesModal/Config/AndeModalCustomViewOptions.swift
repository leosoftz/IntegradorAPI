//
//  AndeModalCustomViewOptions.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 26/05/22.
//

import Foundation

internal class AndeModalCustomViewOptions: NSObject {
    var type: AndesModalType = .card

    var allowsCloseButton = true

    var customView: UIView?

    var title: String?

    var contentSize: AndesModalCustomViewSize = .maxHeight

    var ignoreHorizontalMargins = false
}
