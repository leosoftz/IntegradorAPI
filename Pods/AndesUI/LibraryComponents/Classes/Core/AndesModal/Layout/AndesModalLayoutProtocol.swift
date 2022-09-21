//
//  AndesModalTypeProtocol.swift
//  AndesUI
//
//  Created by Carlos Andres Chaguendo Sanchez on 12/05/22.
//

import UIKit

internal protocol AndesModalLayoutProtocol {
    var margins: UIEdgeInsets { get }
    var imageMargins: UIEdgeInsets { get }
    var footerMargins: UIEdgeInsets { get }
    var cornerRadius: CGFloat { get }
    var backgroundColor: UIColor { get }
    var titleTopMargin: CGFloat { get }
    var titleSize: AndesLabelTitleSize { get }
    var bodySize: AndesLabelBodySize { get }
}
