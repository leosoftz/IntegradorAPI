//
//  AndesBadgeTypeProtocol.swift
//  AndesUI
//

import Foundation

@objc protocol AndesBadgeTypeProtocol {
    var primaryColor: UIColor { get }
    var secondaryColor: UIColor { get }
    var primaryVariantColor: UIColor { get }
    @objc optional func getIcon(size: AndesBadgeSize) -> String
}
