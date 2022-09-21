//
//  UIScrollView+Additions.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 11/05/22.
//

import UIKit

internal extension UIScrollView {
    var topFixedAnchor: NSLayoutYAxisAnchor { frameLayoutGuide.topAnchor }

    var bottomFixedAnchor: NSLayoutYAxisAnchor { frameLayoutGuide.bottomAnchor }
}
