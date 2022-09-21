//
//  AndesLinearProgressIndicatorSizeProtocol.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal.
//

import Foundation

/**
 The AndesLinearProgressIndicatorSizeProtocol provides the differents attributes that define the size of the Indicator, these can be constants or calculated
 */
internal protocol AndesLinearProgressIndicatorSizeProtocol {
    var height: CGFloat { get }
    var splitSize: CGFloat { get }
    var cornerRadius: CGFloat { get }
}
