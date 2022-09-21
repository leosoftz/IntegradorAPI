//
//  
//  AndesTabsTypeProtocol.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

internal protocol AndesTabsTypeProtocol {
    var currentSelection: Int { get }
    var distribution: UIStackView.Distribution { get }
    var textAlignment: NSTextAlignment { get }
    var fullWidthTab: Bool { get }
}
